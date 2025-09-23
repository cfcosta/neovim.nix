local capabilities = require("blink.cmp").get_lsp_capabilities()

local default_options = {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end,
}

local lsp_enable = function(name, args)
  vim.lsp.config[name] = args
  vim.lsp.enable(name)
end

------------------------------------------------------------------
-- Servers Setup
------------------------------------------------------------------
lsp_enable("aiken", default_options)
lsp_enable("bashls", default_options)
lsp_enable("buf_ls", default_options)
lsp_enable("docker_compose_language_service", default_options)
lsp_enable("dockerls", default_options)
lsp_enable("harper_ls", default_options)
lsp_enable("jqls", default_options)
lsp_enable("luau_lsp", default_options)
lsp_enable("nixd", default_options)
lsp_enable("postgres_lsp", default_options)
lsp_enable("ruff", default_options)
lsp_enable("taplo", default_options)

lsp_enable("clangd", {
  capabilities = default_options.capabilities,
  on_attach = default_options.on_attach,
  settings = {
    clangd = {
      InlayHints = {
        Designators = true,
        Enabled = true,
        ParameterNames = true,
        DeducedTypes = true,
      },
      fallbackFlags = { "-std=c++20" },
    },
  },
})

lsp_enable("gopls", {
  capabilities = default_options.capabilities,
  on_attach = default_options.on_attach,
  settings = {
    hints = {
      rangeVariableTypes = true,
      parameterNames = true,
      constantValues = true,
      assignVariableTypes = true,
      compositeLiteralFields = true,
      compositeLiteralTypes = true,
      functionTypeParameters = true,
    },
  },
})

lsp_enable("lua_ls", {
  capabilities = default_options.capabilities,
  on_attach = default_options.on_attach,
  settings = {
    Lua = {
      hints = {
        enable = true,
        setType = true,
        arrayIndex = "Enable",
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
          os.getenv("NIGHTVIM_ROOT") .. "/pack/nightvim/opt",
          vim.env.VIMRUNTIME,
        },
      },
    },
  },
})

lsp_enable("pyright", {
  capabilities = default_options.capabilities,
  on_attach = default_options.on_attach,
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
  },
})

------------------------------------------------------------------
-- Diagnostic Configuration
------------------------------------------------------------------
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
  },
})

------------------------------------------------------------------
-- Keybindings
------------------------------------------------------------------
vim.keymap.set(
  "n",
  "gd",
  "<cmd>lua vim.lsp.buf.declaration()<CR>",
  { noremap = true, silent = true, desc = "LSP: Go to declaration" }
)
vim.keymap.set(
  "n",
  "gD",
  "<cmd>lua vim.lsp.buf.definition()<CR>",
  { noremap = true, silent = true, desc = "LSP: Go to definition" }
)
vim.keymap.set(
  "n",
  "K",
  "<cmd>lua vim.lsp.buf.hover()<CR>",
  { noremap = true, silent = true, desc = "LSP: Show hover information" }
)
vim.keymap.set(
  "n",
  "gi",
  "<cmd>lua vim.lsp.buf.implementation()<CR>",
  { noremap = true, silent = true, desc = "LSP: Go to implementation" }
)
vim.keymap.set(
  "n",
  "<leader>ls",
  "<cmd>lua vim.lsp.buf.signature_help()<CR>",
  { noremap = true, silent = true, desc = "LSP: Show signature help" }
)
vim.keymap.set(
  "n",
  "<leader>D",
  "<cmd>lua vim.lsp.buf.type_definition()<CR>",
  { noremap = true, silent = true, desc = "LSP: Go to type definition" }
)
vim.keymap.set(
  "n",
  "<leader>ca",
  "<cmd>lua vim.lsp.buf.code_action()<CR>",
  { noremap = true, silent = true, desc = "LSP: Code action" }
)
vim.keymap.set(
  "n",
  "<leader>cF",
  "<cmd>lua vim.diagnostic.open_float()<CR>",
  { noremap = true, silent = true, desc = "LSP: Open diagnostic float" }
)
vim.keymap.set(
  "n",
  "[d",
  "<cmd>lua vim.diagnostic.goto_prev()<CR>",
  { noremap = true, silent = true, desc = "LSP: Go to previous diagnostic" }
)
vim.keymap.set(
  "n",
  "d]",
  "<cmd>lua vim.diagnostic.goto_next()<CR>",
  { noremap = true, silent = true, desc = "LSP: Go to next diagnostic" }
)
vim.keymap.set(
  "n",
  "<leader>cq",
  "<cmd>lua vim.diagnostic.setloclist()<CR>",
  { noremap = true, silent = true, desc = "LSP: Set location list" }
)
vim.keymap.set(
  "n",
  "<leader>cr",
  "<cmd>lua vim.lsp.buf.rename()<CR>",
  { noremap = true, silent = true, desc = "LSP: Rename symbol" }
)
