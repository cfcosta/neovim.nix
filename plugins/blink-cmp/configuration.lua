require("blink-cmp").setup({
  fuzzy = {
    prebuilt_binaries = {
      download = false,
      ignore_version_mismatch = true
    },
  },
  signature = { enabled = true }
})
