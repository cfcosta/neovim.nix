require("grug-far").setup({
  keymaps = {
    replace = { n = "<leader>r" },
    qflist = { n = "<leader>q" },
    syncLocations = { n = "<leader>s" },
    syncLine = { n = "<leader>l" },
    close = { n = "<leader>c" },
    historyOpen = { n = "<leader>t" },
    historyAdd = { n = "<leader>a" },
    refresh = { n = "<leader>f" },
    openLocation = { n = "<leader>o" },
    openNextLocation = { n = "<down>" },
    openPrevLocation = { n = "<up>" },
    gotoLocation = { n = "<enter>" },
    pickHistoryEntry = { n = "<enter>" },
    abort = { n = "<leader>b" },
    help = { n = "g?" },
    toggleShowCommand = { n = "<leader>p" },
    swapEngine = { n = "<leader>e" },
    previewLocation = { n = "<leader>i" },
  },
})

vim.api.nvim_set_keymap(
  "n",
  "<leader>fr",
  "<cmd>lua require('grug-far').open({ transient = true })<cr>",
  { noremap = true, silent = true }
)
