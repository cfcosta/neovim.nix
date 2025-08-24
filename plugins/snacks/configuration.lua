local snacks = require("snacks")

snacks.setup({
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  explorer = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = false },
  statuscolumn = { enabled = true },
  words = { enabled = true },
})

vim.keymap.set("n", "<leader>xd", function()
  snacks.picker.diagnostics()
end, { noremap = true, silent = true, desc = "Snacks: show diagnostics" })

vim.keymap.set("n", "<leader>zz", function()
  snacks.zen()
end, { noremap = true, silent = true, desc = "Snacks: Zen mode" })

vim.keymap.set("n", "<leader>op", function()
  snacks.explorer()
end, { noremap = true, silent = true, desc = "Snacks: Toggle file explorer" })
