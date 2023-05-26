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

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<leader>wv", "<cmd>vsplit<cr>")
map("n", "<leader>ws", "<cmd>split<cr>")
map("n", "<leader>wc", "<cmd>close<cr>")
map("n", "<leader>wo", "<cmd>only<cr>")

require("lazy").setup {
  require "plugins.codegpt",
  require "plugins.colorscheme",
  require "plugins.lsp",
  require "plugins.lualine",
  require "plugins.neotree",
  require "plugins.null-ls",
  require "plugins.surround",
  require "plugins.telescope",
  require "plugins.terminal",
  require "plugins.treesitter",
  require "plugins.trouble",
}
