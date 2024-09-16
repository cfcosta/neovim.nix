local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")

local open_with_trouble = require("trouble.sources.telescope").open
local add_to_trouble = require("trouble.sources.telescope").add

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
    file_ignore_patterns = { "node_modules", "%.git" },
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
  extensions = {},
}

require("telescope").setup(options)

vim.api.nvim_set_keymap(
  "n",
  "<leader><leader>",
  "<cmd> Telescope find_files hidden=true<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>/", "<cmd> Telescope live_grep <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>bb", "<cmd> Telescope buffers <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>cm", "<cmd> Telescope git_commits <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gt", "<cmd> Telescope git_status <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>ff",
  "<cmd> Telescope lsp_workspace_symbols <CR>",
  { noremap = true, silent = true }
)