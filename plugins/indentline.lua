local highlight = {
  "IBL1",
  "IBL2",
  "IBL3",
  "IBL4",
  "IBL5",
  "IBL6",
}

local hooks = require("ibl.hooks")

-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "IBL1", { fg = "#282D45" })
  vim.api.nvim_set_hl(0, "IBL2", { fg = "#2F3552" })
  vim.api.nvim_set_hl(0, "IBL3", { fg = "#373D5E" })
  vim.api.nvim_set_hl(0, "IBL4", { fg = "#3E466B" })
  vim.api.nvim_set_hl(0, "IBL5", { fg = "#464E78" })
  vim.api.nvim_set_hl(0, "IBL6", { fg = "#4D5685" })
end)

-- Hide first level of indenting
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)

require("ibl").setup({
  indent = { highlight = highlight },
  exclude = {
    filetype = {
      "help",
      "terminal",
      "lspinfo",
      "TelescopePrompt",
      "TelescopeResults",
      "",
    },
  },
})
