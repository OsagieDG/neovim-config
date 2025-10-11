local on_attach = function(client, bufnr)
  client = client
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('gopls', {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = { gopls = { gofumpt = true } },
})

vim.lsp.config('clangd', {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config('ols', {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config('svelte', {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config("sourcekit", {
  on_attach = on_attach,
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
  filetypes = { "swift" },
})

vim.lsp.config("kotlin_lsp", {
  cmd = { "kotlin-language-server" },
  filetypes = { "kotlin" },
  root_dir = vim.fs.root(0, {
    "settings.gradle",
    "settings.gradle.kts",
    "build.gradle",
    "build.gradle.kts",
    ".git"
  }),
  on_attach = on_attach,
  capabilities = capabilities,
})



vim.lsp.config('rust_analyzer', {
  on_attach = on_attach,
  capabilities = capabilities,
})


vim.lsp.config('lua_ls', {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config('ts_ls', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "javascript", "typescript" },
})

vim.lsp.config('pyright', {
  on_attach = on_attach,
  capabilities = capabilities,
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
})

vim.lsp.config('html',
  {
    on_attach = on_attach,
    settings = {
      html = {
        suggest = { html5 = true },
        format = { enable = true },
        diagnostics = {
          enable = true,
          validate = true
        },
      },
    },
  })

vim.lsp.config('cssls',
  {
    on_attach = on_attach,
    capabilities = capabilities,
  })

vim.lsp.config('yamlls', {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    on_attach(client, bufnr)
  end,
  flags = { debounce_text_changes = 150 },
  capabilities = capabilities,
  settings = {
    yaml = { format = { enable = true }, schemaStore = { enable = true } }
  }
})

vim.lsp.config('mojo', {
  cmd = { 'mojo-lsp-server' },
  single_file_support = true,
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.keymap.set("n", "<leader>fmt", function()
      vim.cmd("noa silent !mojo format --quiet " .. vim.fn.expand("%:p"))
    end, { buffer = bufnr })
  end,
  filetypes = { "mojo" },
})

vim.lsp.enable({
  'gopls',
  'sourcekit',
  'clangd',
  'ols',
  'kotlin_lsp',
  'svelte',
  'rust_analyzer',
  'lua_ls',
  'ts_ls',
  'pyright',
  'html',
  'cssls',
  'yamlls',
  'mojo',
})
