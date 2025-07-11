require("blink-cmp").setup({
  cmdline = {
    enabled = true,

    keymap = {
      preset = "cmdline",
    },
  },

  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 0,
    },

    ghost_text = { enabled = true },

    menu = {
      auto_show = true,

      draw = {
        columns = { { "kind_icon" }, { "label", gap = 1 } },

        components = {
          label = {
            text = function(ctx)
              return require("colorful-menu").blink_components_text(ctx)
            end,
            highlight = function(ctx)
              return require("colorful-menu").blink_components_highlight(ctx)
            end,
          },
        },
      },
    },
  },

  fuzzy = {
    prebuilt_binaries = {
      download = false,
      ignore_version_mismatch = true,
    },
  },

  keymap = {
    preset = "super-tab",
  },

  signature = {
    enabled = true,
  },

  sources = {
    default = { "avante", "lsp", "path", "snippets", "buffer" },
    providers = {
      avante = {
        name = "avante",
        module = "blink-cmp-avante",
      },
      lsp = {
        score_offset = 998,
      },
      snippets = {
        score_offset = 999,
      },
    },
  },
})
