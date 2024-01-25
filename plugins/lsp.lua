local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

-- Python
lspconfig.pylyzer.setup({})

-- Nix
lspconfig.nixd.setup({})

-- Typescript
lspconfig.tsserver.setup({})
lspconfig.eslint.setup({})

-- Protocol Buffers
lspconfig.bufls.setup({})

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
