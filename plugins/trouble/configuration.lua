require("trouble").setup({})

map("n", "<leader>xx", "<cmd>Trouble<cr>")
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>")
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>")
map("n", "<leader>xq", "<cmd>Trouble quicklist<cr>")
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>")
map("n", "gr", "<cmd>Trouble lsp_references<cr>")
