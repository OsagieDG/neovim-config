local lspconfig = require 'lspconfig'

local on_attach = function(client, bufnr)
  client = client
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = { gopls = { gofumpt = true } }
}

lspconfig.clangd.setup {
  on_attach = on_attach
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

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
}


lspconfig.ts_ls.setup {
  on_attach = on_attach
}

lspconfig.ols.setup({

})

lspconfig.pyright.setup {
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


local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require('cmp_nvim_lsp')
lsp_capabilities = cmp_nvim_lsp.default_capabilities(lsp_capabilities)

lspconfig["mojo"].setup({
  cmd = { 'mojo-lsp-server' },
  root_dir = vim.fs.dirname,
  single_file_support = true,
  capabilities = lsp_capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.keymap.set("n", "<leader>fmt",
      function() vim.cmd("noa silent !mojo format --quiet " .. vim.fn.expand("%:p")) end) -- manually format
  end,
  filetypes = { "mojo", "*.🔥" },
})
