local fff = require("fff")

fff.setup({})

vim.keymap.set(
  "n",
  "<leader><leader>",
  fff.find_in_git_root,
  { noremap = true, silent = true, desc = "fff: find file in git repo" }
)
vim.keymap.set(
  "n",
  "<leader>ff",
  fff.find_files,
  { noremap = true, silent = true, desc = "fff: find file" }
)
