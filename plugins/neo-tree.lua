vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require("neo-tree").setup({
  window = {
    position = "left",
    width = 32,
  },
  filesystem = {
    hijack_netrw_behavior = "open_current",
    use_libuv_file_watcher = true,

    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = true,

      always_show = {
        ".env",
      },
    },
  },
})
