vim.g.neo_tree_remove_legacy_commands = 1

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
  ".git",
  ".aider.chat.history.md",
  ".aider.input.history",
  ".direnv",
  ".jj",
  ".obsidian",
  ".stfolder",
  ".trash",
  ".versions",
  "node_modules",
  "target"
}

-- Add global gitignore entries
local global_gitignore = read_file(os.getenv("HOME") .. "/.config/git/ignore")
add_ignore(ignore, global_gitignore)

-- Add local .gitignore entries
local local_gitignore = read_file(".gitignore")
add_ignore(ignore, local_gitignore)

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

      never_show = ignore,
    },
  },
  sources = {
    "filesystem",
    "buffers",
    "jj"
  },
  source_selector = {
    sources = {
      {
        display_name = " 󰉓 Files",
        source = "filesystem",
      },
      {
        display_name = "󰈙 Buffers",
        source = "buffers",
      },
      {
        display_name = "󰊢 JJ",
        source = "jj",
      }
    },
  },
})

vim.keymap.set(
  "n",
  "<leader>op",
  "<cmd>Neotree toggle source=filesystem reveal=true<cr>",
  { noremap = true, silent = true, desc = "neotree: toggle tree" }
)
vim.keymap.set(
  "n",
  "<leader>jj",
  "<cmd>Neotree jj reveal=true position=float<cr>",
  { noremap = true, silent = true, desc = "neotree: open jujutsu status" }
)
vim.keymap.set(
  "n",
  "<leader>ob",
  "<cmd>Neotree buffers reveal=true position=float<cr>",
  { noremap = true, silent = true, desc = "neotree: open buffer list" }
)
