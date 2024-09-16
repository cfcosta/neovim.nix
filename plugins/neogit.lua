require("neogit").setup({
  use_magit_keybindings = true,
  integrations = {
    diffview = true,
  },
})

vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>Neogit<cr>", { noremap = true, silent = true })
