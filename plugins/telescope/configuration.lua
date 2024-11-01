local telescope = require("telescope")
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")

local open_with_trouble = require("trouble.sources.telescope").open
local add_to_trouble = require("trouble.sources.telescope").add

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
  ".aider.chat.history.md",
  ".aider.input.history",
  "%.git",
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

local options = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--ignore-vcs",
      "--hidden",
    },
    prompt_prefix = " >  ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    find_command = { "rg", "--files", "--hidden", "--ignore-vcs" },
    file_sorter = sorters.get_fuzzy_file,
    file_ignore_patterns = ignore,
    generic_sorter = sorters.get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" },
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    buffer_previewer_maker = previewers.buffer_previewer_maker,
    mappings = {
      n = {
        ["q"] = actions.close,
        ["<c-t>"] = open_with_trouble,
        ["<c-a>"] = add_to_trouble,
      },
      i = {
        ["<esc>"] = actions.close,
        ["<c-t>"] = open_with_trouble,
        ["<c-a>"] = add_to_trouble,
      },
    },
  },
  extensions_list = { "themes", "terms" },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
  },
}

telescope.setup(options)
telescope.load_extension("ui-select")

vim.keymap.set(
  "n",
  "<leader><leader>",
  "<cmd> Telescope find_files hidden=true<CR>",
  { noremap = true, silent = true, desc = "telescope: find files" }
)
vim.keymap.set(
  "n",
  "<leader>/",
  "<cmd> Telescope live_grep <CR>",
  { noremap = true, silent = true, desc = "telescope: find on files" }
)
vim.keymap.set(
  "n",
  "<leader>gc",
  "<cmd> Telescope git_commits <CR>",
  { noremap = true, silent = true, desc = "telescope: git commits" }
)
vim.keymap.set(
  "n",
  "<leader>gs",
  "<cmd> Telescope git_status <CR>",
  { noremap = true, silent = true, desc = "telescope: git status" }
)
vim.keymap.set(
  "n",
  "<leader>ct",
  "<cmd> Telescope lsp_workspace_symbols <CR>",
  { noremap = true, silent = true, desc = "telescope: lsp workspace symbols" }
)
