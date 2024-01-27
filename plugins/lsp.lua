local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

local root_files = {
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "pyrightconfig.json",
  ".git",
}

local function organize_imports()
  local params = {
    command = "pyright.organizeimports",
    arguments = { vim.uri_from_bufnr(0) },
  }

  local clients = vim.lsp.get_active_clients({
    bufnr = vim.api.nvim_get_current_buf(),
    name = "pyright",
  })
  for _, client in ipairs(clients) do
    client.request("workspace/executeCommand", params, nil, 0)
  end
end

local function set_python_path(path)
  local clients = vim.lsp.get_active_clients({
    bufnr = vim.api.nvim_get_current_buf(),
    name = "pyright",
  })
  for _, client in ipairs(clients) do
    client.config.settings = vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
    client.notify("workspace/didChangeConfiguration", { settings = nil })
  end
end

-- Python
lspconfig.pylyzer.setup({})
lspconfig.pyright.setup({
  default_config = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_dir = function(fname)
      return util.root_pattern(unpack(root_files))(fname)
    end,
    single_file_support = true,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
        },
      },
    },
  },
  commands = {
    PyrightOrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
    PyrightSetPythonPath = {
      set_python_path,
      description = "Reconfigure pyright with the provided python path",
      nargs = 1,
      complete = "file",
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
