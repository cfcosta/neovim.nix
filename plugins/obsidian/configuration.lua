local function directory_exists(path)
  local stat = vim.uv.fs_stat(path)
  return stat and stat.type == "directory" or false
end

local workspaces = {}
local notes_path = os.getenv("HOME") .. "/Notes"

if directory_exists(notes_path) then
  table.insert(workspaces, { name = "personal", path = "~/Notes" })
else
  table.insert(workspaces, { name = "personal", path = "~" })
end

require("obsidian").setup({
  legacy_commands = false,
  notes_subdir = "notes",
  workspaces = workspaces,
  ui = {
    enable = false,
  },
})

local obsidian_commands = require("obsidian.commands")

local function run_obsidian(...)
  local fargs = { ... }

  obsidian_commands.handle_command({
    args = table.concat(fargs, " "),
    bang = false,
    fargs = fargs,
    line1 = 0,
    line2 = 0,
    mods = "",
    range = 0,
  })
end

vim.keymap.set("n", "<leader>n/", function()
  run_obsidian("search")
end, { desc = "Obsidian: Search notes" })
vim.keymap.set("n", "<leader>nT", function()
  run_obsidian("tomorrow")
end, { desc = "Obsidian: Open tomorrow's note" })
vim.keymap.set("n", "<leader>nd", function()
  run_obsidian("dailies")
end, { desc = "Obsidian: Find daily notes" })
vim.keymap.set("n", "<leader>nt", function()
  run_obsidian("today")
end, { desc = "Obsidian: Open today's note" })
vim.keymap.set("n", "<leader>ny", function()
  run_obsidian("yesterday")
end, { desc = "Obsidian: Open yesterday's note" })
vim.keymap.set("n", "<leader>ns", function()
  run_obsidian("quick_switch")
end, { desc = "Obsidian: Quick switch note" })

vim.keymap.set("n", "<leader>nn", function()
  run_obsidian("dailies", tostring(-tonumber(vim.fn.strftime("%u"))))
end, { desc = "Obsidian: search on currently week notes" })

vim.keymap.set("n", "<leader>nN", function()
  run_obsidian(
    "dailies",
    tostring((-tonumber(vim.fn.strftime("%u"))) - 7),
    tostring((-tonumber(vim.fn.strftime("%u"))) - 1)
  )
end, { desc = "Obsidian: search on previous week notes" })
