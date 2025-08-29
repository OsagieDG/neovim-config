require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "go", "swift",
    "javascript", "python",
    "html", "css",
    "yaml" },
  ignore_install = {},
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
  },

  modules = {
  },

}
