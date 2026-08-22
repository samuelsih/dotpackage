-- kitty renders the char under the block cursor with cursor_text_color,
-- which is dark (#141b1e) in the everblush theme. Give nvim's window an
-- inverted cursor: dark block + light text, shell windows keep their own.

if not os.getenv("KITTY_LISTEN_ON") or vim.fn.executable("kitty") == 0 then
  return
end

vim.fn.jobstart({
  "kitty", "@", "set-colors",
  "cursor=#2d3437", "cursor_text_color=#dadada",
}, { detach = true })
