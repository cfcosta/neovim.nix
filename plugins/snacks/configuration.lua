local snacks = require("snacks")

snacks.setup({
  bigfile = { enabled = true },
  dashboard = {
    enabled = true,
    preset = {
      header = [[
░▒▓███████▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓██████████████▓▒░
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░    ░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒▒▓███▓▒░▒▓████████▓▒░  ░▒▓█▓▒░    ░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░     ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░     ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░      ░▒▓██▓▒░  ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ]],
    },
    sections = {
      { section = "header" },
      { icon = " ", title = "Recent Files", section = "recent_files", padding = 2 },
      { icon = " ", title = "Projects", section = "projects", padding = 2 },
    },
  },
  explorer = {
    enabled = true,
    replace_netrw = true,
  },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = { enabled = true },
  picker = {
    enabled = true,
    layout = { preset = "ivy" },
    sources = {
      explorer = {
        layout = {
          preset = "sidebar",
          auto_hide = { "input" },
          preview = false,
        },
      },
    },
  },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = false },
  statuscolumn = { enabled = true },
  win = {
    input = {
      keys = {
        ["<Esc>"] = "close",
      },
    },
  },
  words = { enabled = true },
})

vim.keymap.set("n", "<leader>/", function()
  snacks.picker.grep()
end, { noremap = true, silent = true, desc = "Snacks: Find in files" })
vim.keymap.set("n", "<leader>bb", function()
  snacks.picker.buffers()
end, { noremap = true, silent = true, desc = "Snacks: Show Buffers" })
vim.keymap.set("n", "<leader>gd", function()
  snacks.git.blame_line()
end, { noremap = true, silent = true, desc = "Snacks: Git Blame current Line" })
vim.keymap.set("n", "<leader>go", function()
  snacks.gitbrowse()
end, { noremap = true, silent = true, desc = "Snacks: Open current line on Github" })
vim.keymap.set("n", "<leader>op", function()
  snacks.explorer()
end, { noremap = true, silent = true, desc = "Snacks: Toggle file explorer" })
vim.keymap.set("n", "<leader>xd", function()
  snacks.picker.diagnostics()
end, { noremap = true, silent = true, desc = "Snacks: show diagnostics" })
vim.keymap.set("n", "<leader>zz", function()
  snacks.zen()
end, { noremap = true, silent = true, desc = "Snacks: Zen mode" })
