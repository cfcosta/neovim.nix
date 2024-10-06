require("twilight").setup({})

vim.keymap.set(
  "n",
  "<leader>zt",
  ":Twilight<CR>",
  { noremap = true, silent = true, desc = "twilight: toggle concealing" }
)
