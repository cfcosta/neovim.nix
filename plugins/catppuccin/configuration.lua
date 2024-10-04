require("catppuccin").setup({
  flavor = "mocha",
  default_integrations = true,
  integrations = {
    cmp = true,
    dap = true,
    diffview = true,
    gitsigns = true,
    grug_far = true,
    indent_blankline = true,
    lsp_trouble = true,
    markdown = true,
    neogit = true,
    neotree = true,
    notify = true,
    nvim_surround = true,
    octo = true,
    treesitter = true,
    which_key = true,
    dropbar = {
      enabled = false,
      color_mode = true,
    },
  },
})

vim.cmd.colorscheme("catppuccin")
