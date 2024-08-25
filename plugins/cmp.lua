local cmp = require("cmp")
local compare = require("cmp.config.compare")
local lspkind = require("lspkind")

require("copilot_cmp").setup()

cmp.setup({
  snippet = {
    expand = function(args)
      require("snippy").expand_snippet(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
  }),
  sources = cmp.config.sources({
    { name = "minuet" },
    { name = "snippy" },
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "copilot" },
    { name = "path" },
  }, {
    { name = "buffer" },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol",
      maxwidth = function()
        return math.floor(0.45 * vim.o.columns)
      end,
      ellipsis_char = "...",
      show_labelDetails = true,
    }),
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      compare.exact,
      compare.recently_used,
      compare.score,
      compare.offset,
      compare.order,
      compare.kind,
      compare.sort_text,
      compare.length,
    },
  },
})
