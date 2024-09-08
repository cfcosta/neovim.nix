require("trouble").setup({})

map("n", "<leader>xx", "<cmd>Trouble<cr>")
map("n", "<leader>xd", "<cmd>Trouble diagnostics<cr>")
map("n", "<leader>xl", "<cmd>Trouble lsp_command<cr>")
map("n", "gr", "<cmeTrouble lsp_references<cr>")
map("n", "gd", "<cmeTrouble lsp_definition<cr>")
