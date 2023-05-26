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

local plugins = {
  require "plugins.colorscheme",
  require "plugins.neotree",
  require "plugins.lualine",
  require "plugins.surround",
  require "plugins.telescope",
  require "plugins.treesitter",
  require "plugins.codegpt",
  require "plugins.lsp",
  require "plugins.null-ls",
  require "plugins.trouble",

  -- Dependencies
  { "MunifTanjim/nui.nvim" },
  { "dcampos/cmp-snippy" },
  { "dcampos/nvim-snippy" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/nvim-cmp" },
  { "mfussenegger/nvim-dap" },
  { "neovim/nvim-lspconfig" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "simrat39/rust-tools.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "windwp/nvim-autopairs" },
}

require("lazy").setup(plugins, {
  ignore = { "lazy.nvim" },
  readme = {
    enable = false,
  },
})
