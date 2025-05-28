require("catppuccin").setup({
  flavor = "mocha",
  default_integrations = true,
  transparent_background = false,
  integrations = {
    blink_cmp = true,
    grug_far = true,
    indent_blankline = true,
    lsp_trouble = true,
    markdown = true,
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
    notify = false,
    nvim_surround = true,
    nvimtree = true,
    render_markdown = true,
    telescope = { enabled = true },
    treesitter = true,
    which_key = true,
  },
})

vim.cmd.colorscheme("catppuccin")
