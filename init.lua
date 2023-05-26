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

local config_path = vim.fn.stdpath "config"
package.path = package.path .. ";" .. config_path .. "/?.lua"

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

local keymap = require "keymap"

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
      "mfussenegger/nvim-dap",
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "simrat39/rust-tools.nvim",
      "williamboman/mason-lspconfig.nvim",
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
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = keymap.trouble,
  },

  -- Dependencies
  { "MunifTanjim/nui.nvim" },
  { "neovim/nvim-lspconfig" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "simrat39/rust-tools.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
}

require("lazy").setup(plugins, {
  ignore = { "lazy.nvim" },
  readme = {
    enable = false,
  },
})
