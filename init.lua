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

vim.api.nvim_set_keymap("n", "<leader>wv", "<cmd>vsplit<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ws", "<cmd>split<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>wc", "<cmd>close<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>wo", "<cmd>only<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>ot",
  "<cmd>ToggleTerm direction=horizontal<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>oT", "<cmd>ToggleTerm direction=vertical<cr>", { noremap = true, silent = true })
