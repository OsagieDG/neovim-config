local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
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

-- Plugins
require("lazy").setup({
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "c", "lua",
          "go", "odin",
          "swift", "kotlin",
          "javascript", "python",
          "svelte", "rust",
          "html", "css",
          "yaml",
        },

        highlight = {
          enable = true,
        },

        auto_install = true,
      })
    end,
  },

  -- LSP
  { "neovim/nvim-lspconfig" },

  -- Completion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },

  -- Snippets
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
    end,
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },

  -- LSP UI
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lspsaga").setup({
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

  -- Theme
  {
    "gruvbox-community/gruvbox",
  },

  -- Swift
  {
    "keith/swift.vim",
    ft = "swift",
  },

  -- Xcode tools
  {
    "wojciech-kulik/xcodebuild.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("xcodebuild").setup()
    end,
  },
})

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
