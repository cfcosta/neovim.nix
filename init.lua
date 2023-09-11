vim.g.mapleader = " "

vim.opt.termguicolors = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true

map("n", "<leader>wv", "<cmd>vsplit<cr>")
map("n", "<leader>ws", "<cmd>split<cr>")
map("n", "<leader>wc", "<cmd>close<cr>")
map("n", "<leader>wo", "<cmd>only<cr>")

after("neogit", function()
	map("n", "<leader>gg", "<cmd>Neogit<cr>")
end)

after("neo-tree", function()
	map("n", "<leader>op", "<cmd>Neotree toggle<cr>")
end)

after("toggleterm", function()
	map("n", "<leader>ot", "<cmd>ToggleTerm direction=horizontal<cr>")
	map("n", "<leader>oT", "<cmd>ToggleTerm direction=vertical<cr>")
end)

after("telescope", function()
	map("n", "<leader><leader>", "<cmd> Telescope find_files hidden=true<CR>")
	map("n", "<leader>/", "<cmd> Telescope live_grep <CR>")
	map("n", "<leader>bb", "<cmd> Telescope buffers <CR>")
	map("n", "<leader>cm", "<cmd> Telescope git_commits <CR>")
	map("n", "<leader>gt", "<cmd> Telescope git_status <CR>")
	map("n", "<leader>ff", "<cmd> Telescope lsp_workspace_symbols <CR>")
end)

after("trouble", function()
	map("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
	map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
	map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
	map("n", "<leader>xq", "<cmd>TroubleToggle quicklist<cr>")
	map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>")
	map("n", "gr", "<cmd>TroubleToggle lsp_references<cr>")
end)

after("nvim-lspconfig", function()
	map("n", "gD", vim.lsp.buf.declaration)
	map("n", "gd", vim.lsp.buf.definition)
	map("n", "K", vim.lsp.buf.hover)
	map("n", "gi", vim.lsp.buf.implementation)
	map("n", "<leader>ls", vim.lsp.buf.signature_help)
	map("n", "<leader>D", vim.lsp.buf.type_definition)
	map("n", "<leader>ca", vim.lsp.buf.code_action)
	map("n", "<leader>f", vim.diagnostic.open_float)
	map("n", "[d", vim.diagnostic.goto_prev)
	map("n", "d]", vim.diagnostic.goto_next)
	map("n", "<leader>q", vim.diagnostic.setloclist)
	map("n", "<leader>cr", vim.lsp.buf.rename)
end)
