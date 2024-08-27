require("neogit").setup({
  use_magit_keybindings = true,
  integrations = {
    diffview = true,
  },
})

map("n", "<leader>gg", "<cmd>Neogit<cr>")
