local M = {}

M.plugins = {}

M.init = function()
  vim.api.nvim_set_keymap("n", "<leader>wv", "<cmd>vsplit<cr>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<leader>ws", "<cmd>split<cr>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<leader>wc", "<cmd>close<cr>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<leader>wo", "<cmd>only<cr>", { noremap = true, silent = true })

  vim.g.mapleader = " "

  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }

  vim.opt.expandtab = true
  vim.opt.laststatus = 3
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.shiftwidth = 2
  vim.opt.softtabstop = 2
  vim.opt.splitkeep = "screen"
  vim.opt.tabstop = 2
  vim.opt.termguicolors = true
end

M.setup_plugin = function(name, depends, config)
  M.plugins[name] = { depends = depends, config = config, loaded = false }
end

M.load_plugin = function(name)
  local plugin = M.plugins[name]

  if not plugin then
    error("Plugin " .. plugin .. " not found")
  end

  if plugin.loaded then
    return
  end

  for _, dep_name in ipairs(plugin.depends or {}) do
    local dep = M.plugins[dep_name]

    if not dep then
      error("Dependency " .. dep_name .. " not found")
    end

    M.load_plugin(dep_name)
  end

  plugin.config()
  plugin.loaded = true
end

M.sort_plugins = function()
  local sorted = {}
  local visited = {}

  local function dfs(name)
    if visited[name] then
      return
    end

    visited[name] = true

    local plugin = M.plugins[name]

    if not plugin then
      error("Plugin " .. name .. " not found")
    end

    for _, dep_name in ipairs(plugin.depends) do
      dfs(dep_name)
    end

    table.insert(sorted, name)
  end

  for name, _ in pairs(M.plugins) do
    dfs(name)
  end

  return sorted
end

M.finish = function()
  local sorted_plugins = M.sort_plugins()

  for _, name in ipairs(sorted_plugins) do
    M.load_plugin(name)
  end
end

return M
