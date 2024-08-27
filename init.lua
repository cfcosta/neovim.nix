vim.g.mapleader = " "

vim.opt.termguicolors = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

map("n", "<leader>wv", "<cmd>vsplit<cr>")
map("n", "<leader>ws", "<cmd>split<cr>")
map("n", "<leader>wc", "<cmd>close<cr>")
map("n", "<leader>wo", "<cmd>only<cr>")

after("toggleterm", function()
  map("n", "<leader>ot", "<cmd>ToggleTerm direction=horizontal<cr>")
  map("n", "<leader>oT", "<cmd>ToggleTerm direction=vertical<cr>")
end)

after("trouble", function()
  map("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
  map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
  map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
  map("n", "<leader>xq", "<cmd>TroubleToggle quicklist<cr>")
  map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>")
  map("n", "gr", "<cmd>TroubleToggle lsp_references<cr>")
end)
