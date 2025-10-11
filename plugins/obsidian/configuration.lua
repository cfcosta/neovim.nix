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

vim.keymap.set("n", "<leader>n/", "<cmd> Obsidian search<CR>", { desc = "Obsidian: Search notes" })
vim.keymap.set("n", "<leader>nT", "<cmd> Obsidian tomorrow<CR>", { desc = "Obsidian: Open tomorrow's note" })
vim.keymap.set("n", "<leader>nd", "<cmd> Obsidian dailies<CR>", { desc = "Obsidian: Find daily notes" })
vim.keymap.set("n", "<leader>nt", "<cmd> Obsidian today<CR>", { desc = "Obsidian: Open today's note" })
vim.keymap.set("n", "<leader>ny", "<cmd> Obsidian yesterday<CR>", { desc = "Obsidian: Open yesterday's note" })
vim.keymap.set("n", "<leader>ns", "<cmd> Obsidian quick_switch<CR>", { desc = "Obsidian: Quick switch note" })

vim.keymap.set("n", "<leader>nn", function()
  vim.cmd(("Obsidian dailies %d"):format(-tonumber(vim.fn.strftime("%u"))))
end, { desc = "Obsidian: search on currently week notes" })

vim.keymap.set("n", "<leader>nN", function()
  vim.cmd(
    ("Obsidian dailies %d %d"):format((-tonumber(vim.fn.strftime("%u"))) - 7, (-tonumber(vim.fn.strftime("%u"))) - 1)
  )
end, { desc = "Obsidian: search on previous week notes" })
