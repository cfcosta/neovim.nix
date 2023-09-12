vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require("neo-tree").setup({
  filesystem = {
    filtered_items = {
      always_show = {
        ".dockerignore",
        ".env",
        ".envrc",
        ".github",
        ".gitignore",
        ".gitlab-ci.yml",
        ".justfile",
      },
    },
  },
})
