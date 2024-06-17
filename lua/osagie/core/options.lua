local opt = vim.opt -- for conciseness 

-- line numbers
opt.relativenumber = true
opt.number = true 

-- tabs & identation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line 
opt.cursorline = true

-- appereance 
opt.termguicolors = true 
opt.background = "dark"
opt.signcolumn = "yes"
