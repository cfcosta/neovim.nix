return {
  "akinsho/toggleterm.nvim",
  event = "VeryLazy",
  config = true,
  keys = {
    { "<leader>ot", "<cmd>ToggleTerm direction=horizontal<cr>" },
    { "<leader>oT", "<cmd>ToggleTerm direction=vertical<cr>" },
  },
}
