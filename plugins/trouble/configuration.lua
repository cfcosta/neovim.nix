require("trouble").setup({})

vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble diagnostics<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble lsp_command<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gr", "<cmeTrouble lsp_references<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmeTrouble lsp_definition<cr>", { noremap = true, silent = true })
