require("trouble").setup({})

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble lsp_command<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "gr", "<cmeTrouble lsp_references<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "gd", "<cmeTrouble lsp_definition<cr>", { noremap = true, silent = true })
