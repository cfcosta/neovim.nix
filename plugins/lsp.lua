local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

-- Python
lspconfig.ruff_lsp.setup({
  on_attach = function(client, _)
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

map("n", "gD", vim.lsp.buf.declaration)
map("n", "gd", vim.lsp.buf.definition)
map("n", "K", vim.lsp.buf.hover)
map("n", "gi", vim.lsp.buf.implementation)
map("n", "<leader>ls", vim.lsp.buf.signature_help)
map("n", "<leader>D", vim.lsp.buf.type_definition)
map("n", "<leader>ca", vim.lsp.buf.code_action)
map("n", "<leader>cF", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "d]", vim.diagnostic.goto_next)
map("n", "<leader>cq", vim.diagnostic.setloclist)
map("n", "<leader>cr", vim.lsp.buf.rename)
