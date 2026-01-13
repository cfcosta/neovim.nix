local install_dir = vim.fn.stdpath("cache") .. "/treesitters"
vim.fn.mkdir(install_dir, "p")

require("nvim-treesitter").setup({
  install_dir = install_dir,
})

-- Enable folding using Treesitter
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo[0][0].foldmethod = "expr"

-- Enable indent using Treesitter
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
