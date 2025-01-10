require("todo-comments").setup({})

vim.keymap.set(
  "n",
  "<leader>tt",
  "<cmd> TodoTelescope <CR>",
  { noremap = true, silent = true, desc = "telescope: TODO comments" }
)
vim.keymap.set(
  "n",
  "<leader>xt",
  "<cmd> TroubleTodo <CR>",
  { noremap = true, silent = true, desc = "trouble: TODO comments" }
)
