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

local function get_unique_dependencies(arr)
  local unique_dependencies = {}

  for _, item in ipairs(arr) do
    local name = item[1]
    local dependencies = item.dependencies

    if dependencies then
      for _, dep in ipairs(dependencies) do
        if dep ~= name and not unique_dependencies[dep] then
          unique_dependencies[dep] = true
        end
      end
    end
  end

  -- Convert the unique_dependencies table to a list
  local unique_dependencies_list = {}
  for dep, _ in pairs(unique_dependencies) do
    table.insert(unique_dependencies_list, dep)
  end

  return unique_dependencies_list
end

local function append_arrays(array1, array2)
  local result = {}
  for _, value in ipairs(array1) do
    table.insert(result, value)
  end
  for _, value in ipairs(array2) do
    table.insert(result, value)
  end
  return result
end

local plugins = {
  require "plugins.codegpt",
  require "plugins.colorscheme",
  require "plugins.comment",
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

require("lazy").setup(append_arrays(plugins, get_unique_dependencies(plugins)))
