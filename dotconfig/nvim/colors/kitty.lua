vim.g.colors_name = "kitty"
vim.o.background = "dark"

vim.g.terminal_ansi_colors = {
  "#161616", "#3ddbd9", "#33b1ff", "#ee5396",
  "#42be65", "#be95ff", "#ff7eb6", "#f2f4f8",
  "#525252", "#78a9ff", "#ff7eb6", "#be95ff",
  "#dde1e6", "#ffffff", "#82cfff", "#08bdba",
}

local function hl(name, spec)
  vim.api.nvim_set_hl(0, name, spec)
end

-- ui
hl("Normal", { fg = "#f2f4f8", bg = "#161616" })
hl("Cursor", { fg = "#161616", bg = "#f2f4f8" })
hl("Visual", { bg = "#41414d" })
hl("LineNr", { fg = "#525252" })
hl("CursorLineNr", { fg = "#f2f4f8" })
hl("Search", { fg = "#161616", bg = "#33b1ff" })
hl("IncSearch", { fg = "#161616", bg = "#ee5396" })
hl("MatchParen", { fg = "#161616", bg = "#82cfff" })
hl("Error", { fg = "#ee5396" })
hl("WarningMsg", { fg = "#ff7eb6" })
hl("VertSplit", { fg = "#525252" })
hl("StatusLine", { fg = "#f2f4f8", bg = "#41414d" })
hl("StatusLineNC", { fg = "#525252", bg = "#161616" })
hl("Pmenu", { fg = "#f2f4f8", bg = "#41414d" })
hl("PmenuSel", { fg = "#161616", bg = "#33b1ff" })

-- syntax
hl("Comment", { fg = "#525252" })
hl("Constant", { fg = "#3ddbd9" })
hl("String", { fg = "#ee5396" })
hl("Number", { fg = "#3ddbd9" })
hl("Boolean", { fg = "#3ddbd9" })
hl("Identifier", { fg = "#f2f4f8" })
hl("Function", { fg = "#33b1ff" })
hl("Keyword", { fg = "#be95ff" })
hl("Statement", { fg = "#be95ff" })
hl("Type", { fg = "#42be65" })
hl("PreProc", { fg = "#ff7eb6" })
hl("Special", { fg = "#08bdba" })
hl("Todo", { fg = "#161616", bg = "#ff7eb6" })
