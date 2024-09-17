require("toggleterm").setup({
  size = 72,
})

vim.api.nvim_set_keymap(
  "n",
  "<leader>ot",
  "<cmd>ToggleTerm direction=horizontal<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>oT", "<cmd>ToggleTerm direction=vertical<cr>", { noremap = true, silent = true })
