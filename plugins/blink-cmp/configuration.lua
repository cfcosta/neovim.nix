require("blink-cmp").setup({
  completion = {
    ghost_text = {
      enabled = true,
    },
    menu = {
      draw = {
        treesitter = { 'lsp' }
      }
    }
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

    cmdline = {
      ['<C-y>'] = { 'select_and_accept' },
      ['<Tab>'] = { 'select_and_accept' },
    }
  },
  signature = {
    enabled = true,
  }
})
