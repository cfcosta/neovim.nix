require("snacks").setup({
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  explorer = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
})
vim.keymap.set("n", "<leader>xd", function()
  Snacks.picker.diagnostics()
end, { noremap = true, silent = true, desc = "Snacks: show diagnostics" })
vim.keymap.set("n", "<leader>zz", function()
  Snacks.zen()
end, { noremap = true, silent = true, desc = "Snacks: Zen mode" })
vim.keymap.set("n", "<leader>op", function()
  Snacks.explorer()
end, { noremap = true, silent = true, desc = "Snacks: Toggle file explorer" })
