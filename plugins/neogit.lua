return {
  "TimUntersberger/neogit",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  config = function()
    require("neogit").setup {
      use_magit_keybindings = true,
      integrations = {
        diffview = true,
      },
    }
  end,
  cmd = "Neogit",
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>" },
  },
}
