local lspconfig = require 'lspconfig'

local on_attach = function(client, bufnr)
  client = client
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',
    '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',
    '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = { gopls = { gofumpt = true } }
}

lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false }
    }
  }
}

lspconfig.sourcekit.setup {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
}

lspconfig.ts_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "javascript", "typescript" }
}

lspconfig.svelte.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.html.setup {
  on_attach = on_attach,
  settings = {
    html = {
      suggest = {
        html5 = true,
      },
      format = {
        enable = true,
      },
      diagnostics = {
        enable = true,
        validate = true,
      },
    },
  },
}

lspconfig.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

local lsp_flags = { debounce_text_changes = 150 }

lspconfig.yamlls.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    on_attach(client, bufnr)
  end,
  flags = lsp_flags,
  capabilities = capabilities,
  settings = {
    yaml = {
      format = {
        enable = true
      },
      schemaStore = {
        enable = true
      }
    }
  }
}
