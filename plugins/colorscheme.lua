require("dracula").setup({})
require("catppuccin").setup({
  flavor = "mocha",
})

require("lualine").setup({
  options = {
    theme = "catpuccin",
  },
})

vim.cmd.colorscheme("catppuccin")
