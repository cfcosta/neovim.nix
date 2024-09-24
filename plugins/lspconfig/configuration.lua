local lspconfig = require("lspconfig")

------------------------------------------------------------------
-- Diagnostic Symbols
------------------------------------------------------------------
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

------------------------------------------------------------------
-- Keybindings
------------------------------------------------------------------
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

------------------------------------------------------------------
-- Servers Setup
------------------------------------------------------------------
lspconfig.aiken.setup({})
lspconfig.bashls.setup({})
lspconfig.beancount.setup({})
lspconfig.bufls.setup({})
lspconfig.clangd.setup({})
lspconfig.docker_compose_language_service.setup({})
lspconfig.dockerls.setup({})
lspconfig.gopls.setup({})
lspconfig.jqls.setup({})
lspconfig.nixd.setup({})
lspconfig.postgres_lsp.setup({})
lspconfig.ruff.setup({})
lspconfig.ruff_lsp.setup({})
lspconfig.taplo.setup({})

------------------------------------------------------------------
-- Lua
------------------------------------------------------------------
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      hints = {
        enable = true,
        setType = true,
      },
      runtime = {
        version = "LuaJIT",
        pathStrict = true,
      },
      telemetry = {
        enable = false,
      },
      workspace = {
        check3rdParty = false,

        diagnostics = {
          globals = { "vim" },
        },

        library = {
          os.getenv("NIGHTVIM_ROOT") .. "/pack/nightvim/start",
          vim.env.VIMRUNTIME,
        },
      },
    },
  },
})

------------------------------------------------------------------
-- Go
------------------------------------------------------------------
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
