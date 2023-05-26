vim.g.mapleader = " "

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local config_path = vim.fn.stdpath('config')
package.path = package.path .. ';' .. config_path .. '/?.lua'

local config = {
  colorscheme = require "plugins.colorscheme",
  neotree = require "plugins.neotree",
  lualine = require "plugins.lualine",
  lsp = require "plugins.lsp",
  null_ls = require "plugins.null-ls",
  surround = require "plugins.surround",
  telescope = require "plugins.telescope",
  treesitter = require "plugins.treesitter",
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
  {
    "nvim-treesitter/nvim-treesitter",
    config = config.treesitter,
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

require("lazy").setup(plugins, {
  ignore = { "lazy.nvim" },
  readme = {
    enable = false,
  },
})
