local telescope = require("telescope")
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")

local open_with_trouble = require("trouble.sources.telescope").open
local add_to_trouble = require("trouble.sources.telescope").add

local options = {
  defaults = {
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    buffer_previewer_maker = previewers.buffer_previewer_maker,
    color_devicons = true,
    entry_prefix = "  ",
    file_previewer = previewers.vim_buffer_cat.new,
    file_sorter = sorters.get_fuzzy_file,
    find_command = { "rg", "--files", "--hidden", "--ignore-vcs" },
    generic_sorter = sorters.get_generic_fuzzy_sorter,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    initial_mode = "insert",
    layout_config = {
      horizontal = { prompt_position = "top", preview_width = 0.55, results_width = 0.8 },
      vertical = { mirror = false },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    layout_strategy = "horizontal",
    mappings = {
      n = { ["q"] = actions.close, ["<c-t>"] = open_with_trouble, ["<c-a>"] = add_to_trouble },
      i = { ["<esc>"] = actions.close, ["<c-t>"] = open_with_trouble, ["<c-a>"] = add_to_trouble },
    },
    path_display = { "truncate" },
    prompt_prefix = " >  ",
    qflist_previewer = previewers.vim_buffer_qflist.new,
    selection_caret = "  ",
    selection_strategy = "reset",
    set_env = { ["COLORTERM"] = "truecolor" },
    sorting_strategy = "ascending",
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
    winblend = 0,
  },
  extensions_list = { "themes", "terms" },
  pickers = {
    buffers = { theme = "ivy" },
    find_files = { theme = "ivy" },
    git_commits = { theme = "ivy" },
    live_grep = { theme = "ivy" },
    git_status = { theme = "ivy" },
    lsp_workspace_symbols = { theme = "ivy" },
  },
}

telescope.setup(options)
