vim.g.neo_tree_remove_legacy_commands = 1

require("neo-tree").setup({
  window = {
    position = "left",
    width = 32,
  },
  default_component_configs = {
    name = {
      use_git_status_colors = true,
    },
    modified = {
      symbol = "[+]",
    },
    git_status = {
      symbols = {
        added = "",
        modified = "",
        deleted = "✖",
        renamed = "󰁕",
        untracked = "",
        ignored = "",
        unstaged = "󰄱",
        staged = "",
        conflict = "",
      },
    },
  },
  filesystem = {
    hijack_netrw_behavior = "open_current",
    use_libuv_file_watcher = true,

    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = true,

      always_show = {
        ".env",
        "result",
      },

      never_show = {
        ".git",
        ".obsidian",
        ".stfolder",
        ".trash",
        ".venv",
        ".versions",
      },
    },
  },
})

vim.keymap.set(
  "n",
  "<leader>op",
  "<cmd>Neotree toggle<cr>",
  { noremap = true, silent = true, desc = "neotree: toggle tree" }
)
