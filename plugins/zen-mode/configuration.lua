require("zen-mode").setup({
  width = 80,
  tmux = {
    enabled = vim.env.TMUX ~= nil,
  },
})

vim.keymap.set("n", "<leader>zz", ":ZenMode<CR>", { noremap = true, silent = true, desc = "zen-mode: toggle" })
