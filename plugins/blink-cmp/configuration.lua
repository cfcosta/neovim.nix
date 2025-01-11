require("blink-cmp").setup({
  completion = {
    ghost_text = {
      enabled = true,
    },
  },
  fuzzy = {
    prebuilt_binaries = {
      download = false,
      ignore_version_mismatch = true,
    },
  },
  keymap = {
    ['<C-y>'] = { 'select_and_accept' },
    ['<Tab>'] = { 'select_and_accept' },
  },
  signature = {
    enabled = true,
  }
})
