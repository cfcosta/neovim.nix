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
  "%.git",
  ".aider.chat.history.md",
  ".aider.input.history",
  ".direnv",
  ".jj",
  ".obsidian",
  ".stfolder",
  ".trash",
  ".versions",
  "node_modules",
  "%target"
}

-- Add global gitignore entries
local global_gitignore = read_file(os.getenv("HOME") .. "/.config/git/ignore")
add_ignore(ignore, global_gitignore)

-- Add local .gitignore entries
local local_gitignore = read_file(".gitignore")
add_ignore(ignore, local_gitignore)

-- setup with options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

vim.keymap.set(
  "n",
  "<leader>op",
  "<cmd>NvimTreeToggle<cr>",
  { noremap = true, silent = true, desc = "nvim-tree: toggle tree" }
)
