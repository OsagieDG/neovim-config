-- Enable Persistent Undo
vim.opt.undofile = true

local undodir_path = vim.fn.stdpath('config') .. '/undodir'
vim.opt.undodir = undodir_path

if vim.fn.isdirectory(undodir_path) == 0 then
  vim.fn.mkdir(undodir_path, "p")
end

vim.opt.undolevels = 1000
vim.opt.undoreload = 5000


-- Auto Cleanup Undo Files Older Than 7 Days
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local undodir = tostring(vim.opt.undodir)
    local cmd = string.format("find %s -type f -mtime +7 -delete", undodir)
    vim.fn.system(cmd)
  end,
})

