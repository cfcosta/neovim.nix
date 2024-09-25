require("twilight").setup({})

vim.api.nvim_set_keymap("n", "<leader>zt", ":Twilight<CR>", { noremap = true, silent = true })
