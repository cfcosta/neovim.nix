require("obsidian").setup({
  notes_subdir = "notes",
  workspaces = {
    {
      name = "personal",
      path = "~/Notes",
    },
  },
})

vim.keymap.set("n", "<leader>nn", "<cmd> ObsidianQuickSwitch<CR>", { desc = "obsidian: switch to a note" })
vim.keymap.set("n", "<leader>nd", "<cmd> ObsidianDailies<CR>", { desc = "obsidian: find journal entries" })
vim.keymap.set("n", "<leader>nT", "<cmd> ObsidianTomorrow<CR>", { desc = "obsidian: open journal entry for tomorrow" })
vim.keymap.set("n", "<leader>ns", "<cmd> ObsidianSearch<CR>", { desc = "obsidian: search notes" })
vim.keymap.set("n", "<leader>nt", "<cmd> ObsidianToday<CR>", { desc = "obsidian: open journal entry for today" })
vim.keymap.set(
  "n",
  "<leader>ny",
  "<cmd> ObsidianYesterday<CR>",
  { desc = "obsidian: open journal entry for yesterday" }
)
