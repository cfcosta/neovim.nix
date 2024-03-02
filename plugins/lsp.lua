local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

-- Python
lspconfig.ruff_lsp.setup({
  on_attach = function(client, bufnr)
    client.server_capabilities.hoverProvider = false
  end,
})

local root_files = {
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "pyrightconfig.json",
  ".git",
}

lspconfig.pyright.setup({
  default_config = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_dir = function(fname)
      return util.root_pattern(unpack(root_files))(fname)
    end,
    single_file_support = true,
    settings = {
      pyright = {
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
          autoImportCompletions = true,
        },
      },
    },
  },
})

-- Nix
lspconfig.nixd.setup({})

-- Typescript
lspconfig.tsserver.setup({})
lspconfig.eslint.setup({})

-- Protocol Buffers
lspconfig.bufls.setup({})

-- PostgreSQL
lspconfig.postgres_lsp.setup({})

-- Lua
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- Go
lspconfig.gopls.setup({
  cmd = { "gopls" },
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
  init_options = {
    usePlaceholders = true,
  },
})

-- Aiken
if not configs.aiken then
  configs.aiken = {
    default_config = {
      cmd = { "aiken", "lsp" },
      filetypes = { "aiken" },
      root_dir = function(fname)
        return util.root_pattern("aiken.toml", ".git")(fname)
      end,
    },
    docs = {
      description = [[
    https://github.com/aiken-lang/aiken

    A language server for Aiken Programming Language.
    [Installation](https://aiken-lang.org/installation-instructions)
    ]],
      default_config = {
        cmd = { "aiken", "lsp" },
        root_dir = [[root_pattern("aiken.toml", ".git")]],
      },
    },
  }

  lspconfig.aiken.setup({})
end
