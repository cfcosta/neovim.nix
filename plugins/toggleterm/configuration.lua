require("toggleterm").setup({
  size = 72,
})

vim.keymap.set("n", "<leader>ot", "<cmd>ToggleTerm direction=horizontal<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>oT", "<cmd>ToggleTerm direction=vertical<cr>", { noremap = true, silent = true })
