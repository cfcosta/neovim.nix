local install_dir = vim.fn.stdpath("cache") .. "/treesitters"
vim.fn.mkdir(install_dir, "p")

require("nvim-treesitter").setup({
  install_dir = install_dir,
})

-- Enable indent using Treesitter
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
