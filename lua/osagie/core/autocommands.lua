vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local line_count = vim.api.nvim_buf_line_count(0)
    if line_count > 5000 then
      vim.lsp.buf.format({ async = true })
    else
      vim.lsp.buf.format({ async = false })
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = "silent! %s/\\s\\+$//e",
})
