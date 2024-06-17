require("osagie.core.options")

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' 
  use 'nvim-treesitter/nvim-treesitter' 
  use 'neovim/nvim-lspconfig' 
  use 'hrsh7th/nvim-compe' 
end)


require'nvim-treesitter.configs'.setup {
  ensure_installed = {"go", "c"}, 
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
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting_sync()<CR>', opts)

  require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
      path = true;
      buffer = true;
      nvim_lsp = true;
      nvim_lua = true;
    };
  }

  buf_set_keymap('i', '<C-Space>', 'compe#complete()', { noremap = true, silent = true, expr = true })
  buf_set_keymap('i', '<CR>', 'compe#confirm("<CR>")', { noremap = true, silent = true, expr = true })
  buf_set_keymap('i', '<C-e>', 'compe#close("<C-e>")', { noremap = true, silent = true, expr = true })
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
  on_attach = on_attach,
}

vim.o.completeopt = 'menuone,noselect'
