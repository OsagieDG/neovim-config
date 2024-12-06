require("osagie.core.options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if vim.fn.isdirectory(lazypath) == 0 then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'mbbill/undotree' },


  {
    "ellisonleao/gruvbox.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      vim.g.gruvbox_transparent_bg = true
      vim.cmd("colorscheme gruvbox")
      vim.cmd([[
        highlight Normal guibg=NONE ctermbg=NONE
        highlight LineNr guibg=NONE ctermbg=NONE
        highlight SignColumn guibg=NONE ctermbg=NONE
        highlight EndOfBuffer guibg=NONE ctermbg=NONE
      ]])
    end
  },


  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },

  {
    'glepnir/lspsaga.nvim',
    branch = 'main',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lspsaga').setup({
        ui = {
          hover = { border = "rounded" },
        },
        lightbulb = {
          enable = false,
          sign = false,
          virtual_text = false,
        },
      })
    end,
  },


  {
    'gruvbox-community/gruvbox',
    config = function()
      vim.o.background = "dark"
      vim.g.gruvbox_contrast_dark = "hard"
      vim.cmd [[colorscheme gruvbox]]
      vim.cmd [[highlight Comment guifg=#b8bb26]]
    end,
  },

  })


require'nvim-treesitter.configs'.setup {
  ensure_installed = {"go", "odin", "c", "cpp", "lua", "javascript", "typescript", "python"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

local lspconfig = require'lspconfig'
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts) -- Updated hover functionality with lspsaga
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting_sync()<CR>', opts)
end

lspconfig.gopls.setup{
  on_attach = on_attach,
  settings = {
    gopls = {
      gofumpt = true,
    },
  },
}

lspconfig.clangd.setup{
  on_attach = on_attach
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
      diagnostics = { globals = {'vim'} },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        maxPreload = 2000,
        preloadFileSize = 1000,
      },
      telemetry = { enable = false },
    },
  },
}

lspconfig.ts_ls.setup{
  on_attach = on_attach
}

lspconfig.ols.setup({

})


lspconfig.pyright.setup{
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
        typeCheckingMode = "basic",
      },
    },
  },
}


local util = require('lspconfig.util')

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require('cmp_nvim_lsp')
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

lspconfig["mojo"].setup({
  cmd = { 'mojo-lsp-server' },
	root_dir = util.find_git_ancestor,
	single_file_support = true,
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		vim.keymap.set("n", "<leader>fmt",
			function() vim.cmd("noa silent !mojo format --quiet " .. vim.fn.expand("%:p")) end) -- manually format document
	end,
	filetypes = { "mojo", "*.🔥" },
})


local cmp = require'cmp'
local luasnip = require'luasnip'

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
      else fallback() end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then luasnip.jump(-1)
      else fallback() end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
})
vim.o.completeopt = 'menuone,noselect'


require('telescope').setup{
  defaults = {
    file_ignore_patterns = { "node_modules", ".git" },
    mappings = {
      i = {
        ["<CR>"] = "select_default",
      },
    },
  },
  pickers = {
    find_files = { theme = "dropdown" },
    live_grep = { theme = "ivy" },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
    },
  },
}
require('telescope').load_extension('fzf')


vim.cmd [[command! TrimTrailingSpaces %s/\s\+$//e]]

