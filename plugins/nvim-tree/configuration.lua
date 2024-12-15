local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set("n", "s", api.node.open.vertical, opts("Open in a vertical split"))
  vim.keymap.set("n", "v", api.node.open.horizontal, opts("Open in a horizontal split"))
end

-- setup with options
require("nvim-tree").setup({
  on_attach = on_attach,
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = {
      min = 30,
      max = 50,
      padding = 1,
    },
  },
  renderer = {
    special_files = {
      "Cargo.toml",
      "flake.nix",
      "package.json",
      "pyproject.toml"
    },
  },
  git = {
    enable = true,
  },
  diagnostics = {
    enable = true,
  },
  modified = {
    enable = false,
  },
  filters = {
    enable = true,
    git_ignored = true,
    custom = {
      "^.git$",
      ".jj",
      "build",
      "dist",
      "node_modules",
      "result",
      "target",
      ".obsidian"
    }
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
    ignore_dirs = {
      "^.git$",
      "^.jj$",
      "^build$",
      "^dist$",
      "^node_modules$",
      "^result$",
      "^target$",
      "^.obsidian$",
    },
  },
  actions = {
    open_file = {
      quit_on_open = false,
      eject = true,
      resize_window = true,
      relative_path = true,
      window_picker = {
        enable = false,
      },
    },
    remove_file = {
      close_window = true,
    },
  },
  log = {
    enable = false,
  },
})

vim.keymap.set("n", "<leader>op", "<cmd>NvimTreeToggle<cr>",
  { noremap = true, silent = true, desc = "nvim-tree: toggle tree" })
