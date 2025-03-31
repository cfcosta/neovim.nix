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
  notes_subdir = "notes",
  workspaces = workspaces,
  ui = {
    enable = false,
  },
})

vim.keymap.set("n", "<leader>nn", "<cmd> ObsidianQuickSwitch<CR>", { desc = "Obsidian: Quick switch note" })
vim.keymap.set("n", "<leader>nd", "<cmd> ObsidianDailies<CR>", { desc = "Obsidian: Find daily notes" })
vim.keymap.set("n", "<leader>nT", "<cmd> ObsidianTomorrow<CR>", { desc = "Obsidian: Open tomorrow's note" })
vim.keymap.set("n", "<leader>ns", "<cmd> ObsidianSearch<CR>", { desc = "Obsidian: Search notes" })
vim.keymap.set("n", "<leader>nt", "<cmd> ObsidianToday<CR>", { desc = "Obsidian: Open today's note" })
vim.keymap.set("n", "<leader>ny", "<cmd> ObsidianYesterday<CR>", { desc = "Obsidian: Open yesterday's note" })
