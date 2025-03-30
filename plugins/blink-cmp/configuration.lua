require("blink-cmp").setup({
  cmdline = {
    enabled = true,

    keymap = {
      preset = "cmdline",
    },
  },

  completion = {
    ghost_text = { enabled = true },

    menu = {
      draw = {
        treesitter = { "lsp" },
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
})
