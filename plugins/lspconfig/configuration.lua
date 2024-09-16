local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

local on_attach = function(client, _)
  if not client.supports_method("textDocument/formatting") then
    return
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp", { clear = true }),
    callback = function(args)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ async = false, id = args.data.client_id })
        end,
      })
    end,
  })
end

local default_lsp_config = {
  on_attach = on_attach,
}

------------------------------------------------------------------------
-- Python
------------------------------------------------------------------------
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
  on_attach = on_attach,
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

lspconfig.ruff_lsp.setup({
  on_attach = function(client, bufnr)
    client.server_capabilities.hoverProvider = false

    on_attach(client, bufnr)
  end,
})

------------------------------------------------------------------------
-- Nix
------------------------------------------------------------------------
lspconfig.nixd.setup(default_lsp_config)

------------------------------------------------------------------------
-- Protocol Buffers
------------------------------------------------------------------------
lspconfig.bufls.setup(default_lsp_config)

------------------------------------------------------------------------
-- PostgreSQL
------------------------------------------------------------------------
lspconfig.postgres_lsp.setup(default_lsp_config)

------------------------------------------------------------------------
-- Lua
------------------------------------------------------------------------
lspconfig.lua_ls.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        special = { reload = "require" },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

------------------------------------------------------------------------
-- Go
------------------------------------------------------------------------
lspconfig.gopls.setup({
  on_attach = on_attach,
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

------------------------------------------------------------------------
-- Aiken
------------------------------------------------------------------------
if not configs.aiken then
  configs.aiken = {
    on_attach = on_attach,
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

  lspconfig.aiken.setup(default_lsp_config)
end

------------------------------------------------------------------------
-- Keybindings
------------------------------------------------------------------------
vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>ls",
  "<cmd>lua vim.lsp.buf.signature_help()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>D",
  "<cmd>lua vim.lsp.buf.type_definition()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>cF",
  "<cmd>lua vim.diagnostic.open_float()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "d]", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>cq",
  "<cmd>lua vim.diagnostic.setloclist()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
