require("catppuccin").setup({
  flavor = "mocha",
  default_integrations = true,
  integrations = {
    cmp = true,
    dap = true,
    diffview = true,
    dropbar = { enabled = true, color_mode = true },
    gitsigns = true,
    grug_far = true,
    indent_blankline = true,
    lsp_trouble = true,
    markdown = true,
    neogit = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
        ok = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
        ok = { "underline" },
      },
      inlay_hints = {
        background = true,
      },
    },
    notify = true,
    nvim_surround = true,
    nvimtree = true,
    octo = true,
    render_markdown = true,
    telescope = { enabled = true },
    treesitter = true,
    which_key = true,
  },
})

vim.cmd.colorscheme("catppuccin")
