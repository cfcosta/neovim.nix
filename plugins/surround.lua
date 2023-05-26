return function()
  require("nvim-surround").setup {}

  local options = {
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt", "vim" },
  }

  require("nvim-autopairs").setup(options)
end
