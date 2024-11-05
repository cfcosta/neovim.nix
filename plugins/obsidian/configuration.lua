local function directory_exists(path)
  local command = string.format('test -d "%s" && echo "1" || echo "0"', path)
  local handle = io.popen(command)

  if handle == nil then
    local result = handle:read("*a")
    handle:close()
    return result:trim() == "1"
  end

  return false
end

if directory_exists("~/Notes") then
  require("obsidian").setup({
    notes_subdir = "notes",
    workspaces = {
      name = "personal",
      path = "~/Notes",
    },
  })

  vim.keymap.set("n", "<leader>nT", "<cmd> ObsidianTomorrow<CR>", { desc = "obsidian: open journal entry for tomorrow" })
  vim.keymap.set("n", "<leader>ns", "<cmd> ObsidianSearch<CR>", { desc = "obsidian: search notes" })
  vim.keymap.set("n", "<leader>nt", "<cmd> ObsidianToday<CR>", { desc = "obsidian: open journal entry for today" })
  vim.keymap.set(
    "n",
    "<leader>ny",
    "<cmd> ObsidianYesterday<CR>",
    { desc = "obsidian: open journal entry for yesterday" }
  )
end
