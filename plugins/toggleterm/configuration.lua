require("toggleterm").setup({
  size = 72,
})

vim.keymap.set(
  "n",
  "<leader>ot",
  "<cmd>ToggleTerm direction=horizontal<cr>",
  { noremap = true, silent = true, desc = "toggleterm: open terminal" }
)
vim.keymap.set(
  "n",
  "<leader>oT",
  "<cmd>ToggleTerm direction=vertical<cr>",
  { noremap = true, silent = true, desc = "toggleterm: open terminal in a vertical split" }
)
vim.keymap.set(
  "n",
  "<leader>oF",
  "<cmd>ToggleTerm direction=vertical<cr>",
  { noremap = true, silent = true, desc = "toggleterm: open floating terminal" }
)
