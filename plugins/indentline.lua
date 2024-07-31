local highlight = {
  "IBL1",
  "IBL2",
  "IBL3",
  "IBL4",
  "IBL5",
  "IBL6",
}

local hooks = require("ibl.hooks")

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "IBL1", { fg = "#DCDDF5" })
  vim.api.nvim_set_hl(0, "IBL2", { fg = "#D4D5F8" })
  vim.api.nvim_set_hl(0, "IBL3", { fg = "#CECEF9" })
  vim.api.nvim_set_hl(0, "IBL4", { fg = "#C6C7FB" })
  vim.api.nvim_set_hl(0, "IBL5", { fg = "#BEC1FC" })
  vim.api.nvim_set_hl(0, "IBL6", { fg = "#B8BBFD" })
end)

hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

require("ibl").setup({
  indent = { highlight = highlight },
  whitespace = {
    highlight = highlight,
    remove_blankline_trail = false,
  },
  scope = { enabled = true },
})
