require("catppuccin").setup({
  flavor = "mocha",
  default_integrations = true,
  integrations = {
    cmp = true,
    dap = true,
    diffview = true,
    dropbar = { enabled = false, color_mode = true },
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
    telescope = { enabled = true, style = "nvchad" },
    treesitter = true,
    which_key = true,
  },
})

vim.cmd.colorscheme("catppuccin")
