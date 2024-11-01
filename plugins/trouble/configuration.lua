require("trouble").setup({})

vim.keymap.set(
  "n",
  "<leader>xx",
  "<cmd>Trouble diagnostics<cr>",
  { noremap = true, silent = true, desc = "trouble: open trouble diagnostics" }
)
vim.keymap.set(
  "n",
  "<leader>xl",
  "<cmd>Trouble lsp_command<cr>",
  { noremap = true, silent = true, desc = "trouble: open LSP commands" }
)
