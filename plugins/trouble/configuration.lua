require("trouble").setup({})

vim.keymap.set(
  "n",
  "<leader>xx",
  "<cmd>Trouble diagnostics toggle<cr>",
  { noremap = true, silent = true, desc = "Trouble: Toggle diagnostics" }
)
vim.keymap.set(
  "n",
  "<leader>xX",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { noremap = true, silent = true, desc = "Trouble: Toggle buffer diagnostics" }
)
vim.keymap.set(
  "n",
  "<leader>cs",
  "<cmd>Trouble symbols toggle focus=false<cr>",
  { noremap = true, silent = true, desc = "Trouble: Toggle symbols" }
)
vim.keymap.set(
  "n",
  "<leader>cl",
  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  { noremap = true, silent = true, desc = "Trouble: Toggle LSP references" }
)
vim.keymap.set(
  "n",
  "<leader>xL",
  "<cmd>Trouble loclist toggle<cr>",
  { noremap = true, silent = true, desc = "Trouble: Toggle location list" }
)
vim.keymap.set(
  "n",
  "<leader>xQ",
  "<cmd>Trouble qflist toggle<cr>",
  { noremap = true, silent = true, desc = "Trouble: Toggle quickfix list" }
)
