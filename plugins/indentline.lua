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
  vim.api.nvim_set_hl(0, "IBL1", { fg = "#282D45" })
  vim.api.nvim_set_hl(0, "IBL2", { fg = "#2F3552" })
  vim.api.nvim_set_hl(0, "IBL3", { fg = "#373D5E" })
  vim.api.nvim_set_hl(0, "IBL4", { fg = "#3E466B" })
  vim.api.nvim_set_hl(0, "IBL5", { fg = "#464E78" })
  vim.api.nvim_set_hl(0, "IBL6", { fg = "#4D5685" })
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
