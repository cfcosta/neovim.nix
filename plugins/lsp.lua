return {
  "williamboman/mason.nvim",
  dependencies = {
    "mfussenegger/nvim-dap",
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",
    "simrat39/rust-tools.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "dcampos/nvim-snippy",
    "dcampos/cmp-snippy",
  },
  lazy = false,
  config = function()
    local lspconfig = require "lspconfig"
    local lsp_defaults = lspconfig.util.default_config

    lsp_defaults.capabilities =
        vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

    require("mason").setup()
    require("mason-lspconfig").setup()
    require("mason-lspconfig").setup_handlers {
      function(server_name) -- default handler (optional)
        lspconfig[server_name].setup {}
      end,
      ["rust_analyzer"] = function()
        require("rust-tools").setup {
          capabilities = lsp_defaults.capabilities,
        }
      end,
    }

    local cmp = require "cmp"

    cmp.setup {
      snippet = {
        expand = function(args)
          require("snippy").expand_snippet(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm { select = true },
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "snippy" },
      }, {
        { name = "buffer" },
      }),
    }
  end,
  keys = {
    { "gD",         vim.lsp.buf.declaration },
    { "gd",         vim.lsp.buf.definition },
    { "K",          vim.lsp.buf.hover },
    { "gi",         vim.lsp.buf.implementation },
    { "<leader>ls", vim.lsp.buf.signature_help },
    { "<leader>D",  vim.lsp.buf.type_definition },
    { "<leader>ca", vim.lsp.buf.code_action },
    { "<leader>f",  vim.diagnostic.open_float },
    { "[d",         vim.diagnostic.goto_prev },
    { "d]",         vim.diagnostic.goto_next },
    { "<leader>q",  vim.diagnostic.setloclist },
    {
      "<leader>cr",
      function()
        require("nvchad_ui.renamer").open()
      end,
    },
  },
}
