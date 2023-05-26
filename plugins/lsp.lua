return function()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  require("mason").setup()
  require("mason-lspconfig").setup()
  require("mason-lspconfig").setup_handlers {
    function(server_name) -- default handler (optional)
      require("lspconfig")[server_name].setup {
        capabilities = capabilities,
      }
    end,
    ["rust_analyzer"] = function()
      require("rust-tools").setup {}
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
end
