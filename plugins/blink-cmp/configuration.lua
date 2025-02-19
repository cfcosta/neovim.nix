require("blink-cmp").setup({
  cmdline = {
    keymap = {
      ["<C-y>"] = { "select_and_accept" },
      ["<Tab>"] = { "select_and_accept" },
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
    ["<C-y>"] = { "select_and_accept" },
    ["<Tab>"] = { "select_and_accept" },
  },
  signature = {
    enabled = true,
  },
})
