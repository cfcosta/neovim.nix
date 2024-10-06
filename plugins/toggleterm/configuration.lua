require("toggleterm").setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return 72
    end
  end,
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
  "<leader>of",
  "<cmd>ToggleTerm direction=float<cr>",
  { noremap = true, silent = true, desc = "toggleterm: open floating terminal" }
)
vim.keymap.set(
  "n",
  "<leader>oF",
  "<cmd>ToggleTerm direction=tab<cr>",
  { noremap = true, silent = true, desc = "toggleterm: open terminal in a new tab" }
)
