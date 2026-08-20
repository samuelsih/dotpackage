local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- return to last edit position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 1 and mark[1] <= vim.fn.line("$") then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})
