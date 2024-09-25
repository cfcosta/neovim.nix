require("zen-mode").setup({
  width = 102,
  tmux = {
    enabled = vim.env.TMUX ~= nil,
  },
  twilight = {
    enabled = true,
  },
})

vim.api.nvim_set_keymap("n", "<leader>zz", ":ZenMode<CR>", { noremap = true, silent = true })
