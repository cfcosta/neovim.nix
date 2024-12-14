local function read_file(path)
  local file = io.open(path, "r")
  if not file then return nil end
  local content = file:read("*all")
  file:close()
  return content
end

local function add_ignore(ignore_list, gitignore_content)
  if gitignore_content then
    for line in gitignore_content:gmatch("[^\r\n]+") do
      if line ~= "" and line:sub(1, 1) ~= "#" then
        table.insert(ignore_list, line)
      end
    end
  end
end

local ignore = {
  "^.git$",
  "^.jj$",
  ".aider*",
  "^.aider.conf.yml",
  ".direnv",
  ".jj",
  ".obsidian",
  ".stfolder",
  ".trash",
  ".versions",
  "node_modules",
  "result",
  "^target$"
}

-- Add global gitignore entries
local global_gitignore = read_file(os.getenv("HOME") .. "/.config/git/ignore")
add_ignore(ignore, global_gitignore)

-- Add local .gitignore entries
local local_gitignore = read_file(".gitignore")
add_ignore(ignore, local_gitignore)

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
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    float = {
      enable = false,
      quit_on_focus_loss = true,
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 30,
        height = 30,
        row = 1,
        col = 1,
      },
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    full_name = false,
    root_folder_label = ":~:s?$?/?",
    indent_width = 2,
    special_files = {
      "Cargo.toml",
      "flake.nix",
      "package.json",
      "pyproject.toml"
    },
    hidden_display = "none",
    symlink_destination = false,
    icons = {
      web_devicons = {
        file = {
          enable = true,
          color = true,
        },
        folder = {
          enable = true,
          color = true,
        },
      },
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
        modified = true,
        hidden = false,
        diagnostics = true,
        bookmarks = true,
      },
    },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  system_open = {
    cmd = "",
    args = {},
  },
  git = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    disable_for_dirs = {},
    timeout = 400,
    cygwin_support = false,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    debounce_delay = 500,
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  modified = {
    enable = false,
    show_on_dirs = true,
    show_on_open_dirs = true,
  },
  filters = {
    enable = true,
    git_ignored = true,
    dotfiles = false,
    git_clean = false,
    no_buffer = false,
    no_bookmark = false,
    custom = ignore,
    exclude = {},
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
    ignore_dirs = {
      ".git",
      ".jj",
      "build",
      "dist",
      "node_modules",
      "result",
      "target",
    },
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 300,
      exclude = {},
    },
    file_popup = {
      open_win_config = {
        col = 1,
        row = 1,
        relative = "cursor",
        border = "shadow",
        style = "minimal",
      },
    },
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
  tab = {
    sync = {
      open = false,
      close = false,
      ignore = {},
    },
  },
  notify = {
    threshold = vim.log.levels.INFO,
    absolute_path = true,
  },
  help = {
    sort_by = "key",
  },
  ui = {
    confirm = {
      remove = true,
      trash = true,
      default_yes = false,
    },
  },
  experimental = {
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
  },
  log = {
    enable = false,
  },
})

vim.keymap.set("n", "<leader>op", "<cmd>NvimTreeToggle<cr>",
  { noremap = true, silent = true, desc = "nvim-tree: toggle tree" })
