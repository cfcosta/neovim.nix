local cmp = require("cmp")
local cmp_ai = require("cmp_ai.config")
local compare = require("cmp.config.compare")
local lspkind = require("lspkind")

require("copilot_cmp").setup()

cmp_ai:setup({
  max_lines = 100,
  provider = "Ollama",
  provider_options = {
    model = "llama3:8b",
  },
  notify = true,
  notify_callback = function(msg)
    vim.notify(msg)
  end,
  run_on_every_keystroke = true,
  ignored_file_types = {},
})

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
    { name = "snippy" },
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "cmp_ai" },
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
      before = function(entry, vim_item)
        if entry.source.name == "cmp_ai" then
          vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })

          local detail = (entry.completion_item.labelDetails or {}).detail
          vim_item.menu = "λ"

          if detail and detail:find(".*%%.*") then
            vim_item.kind = vim_item.kind .. " " .. detail
          end

          if (entry.completion_item.data or {}).multiline then
            vim_item.kind = vim_item.kind .. " " .. "[ML]"
          end

          local maxwidth = 80
          vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
        end

        return vim_item
      end,
    }),
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      require("cmp_ai.compare"),
      compare.offset,
      compare.exact,
      compare.score,
      compare.recently_used,
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  },
})
