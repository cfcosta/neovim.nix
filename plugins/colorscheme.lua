require("tokyonight").setup({
  style = "day", -- 'storm', 'moon', 'day',
  transparent = false, -- whether or not to set background
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark",
    floats = "dark",
  },
})

vim.cmd([[colorscheme tokyonight]])
