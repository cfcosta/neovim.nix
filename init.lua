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
  require "plugins.terminal",
}

require("lazy").setup(plugins)
