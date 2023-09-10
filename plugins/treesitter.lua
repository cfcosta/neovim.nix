local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
vim.fn.mkdir(parser_install_dir, "p")

local new_runtimepath = vim.opt.runtimepath:get()
table.insert(new_runtimepath, 1, parser_install_dir)
vim.opt.runtimepath = new_runtimepath

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
