require("todo-comments").setup({})

vim.keymap.set(
  "n",
  "<leader>tt",
  "<cmd> TodoTelescope <CR>",
  { noremap = true, silent = true, desc = "Todo: Find comments with Telescope" }
)
vim.keymap.set(
  "n",
  "<leader>xt",
  "<cmd> TodoTrouble <CR>",
  { noremap = true, silent = true, desc = "Todo: Find comments with Trouble" }
)
