local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
vim.fn.mkdir(parser_install_dir, "p")
vim.opt.runtimepath:append(parser_install_dir)

require("nvim-treesitter.configs").setup({
	ensure_installed = { "rust", "nix", "lua", "c", "vim", "vimdoc" },
	sync_install = false,
	auto_install = true,
	highlight = { enable = true },
	endwise = { enable = true },
	indent = { enable = true },
	parser_install_dir = parser_install_dir,
})

-- Enable folding using treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
