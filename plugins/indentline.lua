vim.cmd([[highlight IndentBlanklineIndent1 guifg=#282D45 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#2F3552 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#373D5E gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#3E466B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#464E78 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent6 guifg=#4D5685 gui=nocombine]])

require("indent_blankline").setup({
  filetype_exclude = {
    "help",
    "terminal",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
    "",
  },
  buftype_exclude = { "terminal" },
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  show_current_context = true,
  show_current_context_start = true,
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },
})
