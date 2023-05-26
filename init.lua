vim.g.mapleader = " "

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

local config = {
  colorscheme = function()
    vim.cmd [[colorscheme tokyonight]]
  end,
  neotree = function()
    vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]
    require("neo-tree").setup()
  end,
  lualine = function()
    require("lualine").setup()
  end,
  lsp = function()
    require("mason").setup()
    require("mason-lspconfig").setup()

    local lspconfig = require "lspconfig"

    lspconfig.lua_ls.setup {}
    lspconfig.rust_analyzer.setup {}
    lspconfig.docker_compose_language_service.setup {}
    lspconfig.gopls.setup {}
    lspconfig.jsonls.setup {}
  end,
  null_ls = function()
    local null_ls = require "null-ls"
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.eslint,
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.nixfmt,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.diagnostics.shellcheck,
      },
      on_attach = function(client, bufnr)
        if client.supports_method "textDocument/formatting" then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { bufnr = bufnr }
            end,
          })
        end
      end,
    }
  end,
  surround = function()
    require("nvim-surround").setup {}
  end,
  telescope = function()
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
        },
        prompt_prefix = "   ",
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
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules", ".git" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
          n = { ["q"] = require("telescope.actions").close },
        },
      },

      extensions_list = { "themes", "terms" },
    }

    require("telescope").setup(options)
  end,
}

local keymap = {
  neotree = {
    { "<leader>op", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
  },
  telescope = {
    -- find
    { "<leader><leader>", "<cmd> Telescope find_files hidden=true<CR>", desc = "find files" },
    { "<leader>/", "<cmd> Telescope live_grep <CR>", desc = "live grep" },
    { "<leader>bb", "<cmd> Telescope buffers <CR>", desc = "find buffers" },

    -- git
    { "<leader>cm", "<cmd> Telescope git_commits <CR>", desc = "git commits" },
    { "<leader>gt", "<cmd> Telescope git_status <CR>", desc = "git status" },
  },
  lsp = {
    {
      "gD",
      function()
        vim.lsp.buf.declaration()
      end,
      desc = "lsp declaration",
    },
    {
      "gd",
      function()
        vim.lsp.buf.definition()
      end,
      desc = "lsp definition",
    },
    {
      "K",
      function()
        vim.lsp.buf.hover()
      end,
      desc = "lsp hover",
    },
    {
      "gi",
      function()
        vim.lsp.buf.implementation()
      end,
      desc = "lsp implementation",
    },
    {
      "<leader>ls",
      function()
        vim.lsp.buf.signature_help()
      end,
      desc = "lsp signature_help",
    },
    {
      "<leader>D",
      function()
        vim.lsp.buf.type_definition()
      end,
      desc = "lsp definition type",
    },
    {
      "<leader>rr",
      function()
        require("nvchad_ui.renamer").open()
      end,
      desc = "lsp rename",
    },
    {
      "<leader>ca",
      function()
        vim.lsp.buf.code_action()
      end,
      desc = "lsp code_action",
    },
    {
      "gr",
      function()
        vim.lsp.buf.references()
      end,
      desc = "lsp references",
    },
    {
      "<leader>f",
      function()
        vim.diagnostic.open_float()
      end,
      desc = "floating diagnostic",
    },
    {
      "[d",
      function()
        vim.diagnostic.goto_prev()
      end,
      desc = "goto prev",
    },
    {
      "d]",
      function()
        vim.diagnostic.goto_next()
      end,
      desc = "goto_next",
    },
    {
      "<leader>q",
      function()
        vim.diagnostic.setloclist()
      end,
      desc = "diagnostic setloclist",
    },
  },
}

local plugins = {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = config.colorscheme,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = keymap.neotree,
    config = config.neotree,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = config.lualine,
  },
  {
    "kylechui/nvim-surround",
    config = config.surround,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = keymap.telescope,
    config = config.telescope,
  },

  -- LSP
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = config.lsp,
    keys = keymap.lsp,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = config.null_ls,
  },

  -- Dependencies
  { "MunifTanjim/nui.nvim" },
  { "neovim/nvim-lspconfig" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "williamboman/mason-lspconfig.nvim" },
}

require("lazy").setup(plugins)
