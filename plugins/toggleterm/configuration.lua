require("toggleterm").setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return 72
    end
  end,
  winbar = {
    enable = true,
  },
})

vim.keymap.set(
  "n",
  "<leader>]",
  "<cmd>ToggleTermSendCurrentLine<cr>",
  { noremap = true, silent = true, desc = "ToggleTerm: Send current line to terminal" }
)
vim.keymap.set(
  "n",
  "<leader>oF",
  "<cmd>ToggleTerm direction=tab<cr>",
  { noremap = true, silent = true, desc = "ToggleTerm: Open terminal in new tab" }
)
vim.keymap.set(
  "n",
  "<leader>oT",
  "<cmd>ToggleTerm direction=vertical<cr>",
  { noremap = true, silent = true, desc = "ToggleTerm: Open vertical terminal" }
)
vim.keymap.set(
  "n",
  "<leader>of",
  "<cmd>ToggleTerm direction=float<cr>",
  { noremap = true, silent = true, desc = "ToggleTerm: Open floating terminal" }
)
vim.keymap.set(
  "n",
  "<leader>ot",
  "<cmd>ToggleTerm direction=horizontal<cr>",
  { noremap = true, silent = true, desc = "ToggleTerm: Open horizontal terminal" }
)
