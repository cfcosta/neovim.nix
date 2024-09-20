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
  vim.api.nvim_set_hl(0, "IBL1", { fg = "#45475a" }) -- Surface1
  vim.api.nvim_set_hl(0, "IBL2", { fg = "#585b70" }) -- Surface2
  vim.api.nvim_set_hl(0, "IBL3", { fg = "#6c7086" }) -- Overlay0
  vim.api.nvim_set_hl(0, "IBL4", { fg = "#7f849c" }) -- Overlay1
  vim.api.nvim_set_hl(0, "IBL5", { fg = "#9399b2" }) -- Overlay2
  vim.api.nvim_set_hl(0, "IBL6", { fg = "#a6adc8" }) -- Subtext0
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
