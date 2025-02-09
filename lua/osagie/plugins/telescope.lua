require('telescope').setup {
  defaults = {
    file_ignore_patterns = { "node_modules/.*", "%.git/.*" },
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

