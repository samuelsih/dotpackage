import { writeFile } from "node:fs/promises";
import { resolve } from "node:path";

import type { AssistantMessage } from "@earendil-works/pi-ai";
import type {
	ContextEditEntry,
	ContextEditEntryDraft,
	CustomMessageEntry,
	ExtensionAPI,
} from "@earendil-works/pi-coding-agent";
import { Box, Text } from "@earendil-works/pi-tui";

const ENTRY_TYPE = "save-md";

interface SaveMarkdownData {
	path: string;
}

function textContent(content: unknown): string {
	if (!Array.isArray(content)) return "";

	return content
		.filter(
		(block): block is { type: "text"; text: string } =>
			typeof block === "object" &&
			block !== null &&
			"type" in block &&
			block.type === "text" &&
			"text" in block &&
			typeof block.text === "string",
		)
		.map((block) => block.text)
		.join("\n\n");
}

export default function saveMarkdownExtension(pi: ExtensionAPI) {
	pi.registerEntryRenderer<SaveMarkdownData>(
		ENTRY_TYPE,
		(entry, { expanded }, theme) => {
			const box = new Box(1, 1, (text) => theme.bg("customMessageBg", text));
			box.addChild(
				new Text(
					`${theme.fg("accent", "[save-md]")} Saved Markdown to ${entry.data?.path ?? "unknown"}`,
					0,
					0,
				),
			);
			if (expanded) {
				box.addChild(
					new Text(theme.fg("dim", new Date(entry.timestamp).toLocaleString()), 0, 0),
				);
			}
			return box;
		},
	);

	pi.on("agent_before_settle", async (_event, ctx) => {
		const branch = ctx.sessionManager.getBranch();
		const editedTargets = new Set(
			branch
				.filter((entry): entry is ContextEditEntry => entry.type === "context_edit")
				.map((entry) => entry.targetId),
		);
		const legacyMessages = branch.filter(
			(entry): entry is CustomMessageEntry =>
				entry.type === "custom_message" &&
				entry.customType === ENTRY_TYPE &&
				!editedTargets.has(entry.id),
		);
		if (legacyMessages.length === 0) return;
		return {
			entries: legacyMessages.map(
				(entry): ContextEditEntryDraft => ({
					type: "context_edit",
					targetId: entry.id,
					replacement: null,
				}),
			),
		};
	});

	pi.registerCommand("save-md", {
		description: "Save the latest assistant response as Markdown (usage: /save-md name)",
		handler: async (args, ctx) => {
			await ctx.waitForIdle();

			const branch = ctx.sessionManager.getBranch();
			let assistantMessage: AssistantMessage | undefined;
			for (let index = branch.length - 1; index >= 0; index--) {
				const entry = branch[index];
				if (entry?.type === "message" && entry.message.role === "assistant") {
					assistantMessage = entry.message;
					break;
				}
			}
			if (!assistantMessage) {
				ctx.ui.notify("No assistant response to save", "warning");
				return;
			}

			const name = args.trim();
			if (!name) {
				ctx.ui.notify("Usage: /save-md name", "warning");
				return;
			}

			const markdown = textContent(assistantMessage.content);
			if (!markdown.trim()) {
				ctx.ui.notify(
					"The latest assistant response has no Markdown text",
					"warning",
				);
				return;
			}

			const fileName = name.endsWith(".md") ? name : `${name}.md`;
			const path = resolve(ctx.cwd, fileName);

			try {
				await writeFile(path, markdown.endsWith("\n") ? markdown : `${markdown}\n`, {
					encoding: "utf8",
					flag: "wx",
				});
			} catch (error) {
				if (
					typeof error === "object" &&
					error !== null &&
					"code" in error &&
					error.code === "EEXIST"
				) {
					ctx.ui.notify(`File already exists: ${path}`, "error");
					return;
				}
				throw error;
			}

			const message = `Saved Markdown to ${path}`;
			pi.appendEntry<SaveMarkdownData>(ENTRY_TYPE, { path });
			ctx.ui.notify(message, "info");
		},
	});
}
