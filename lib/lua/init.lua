local M = {}

M.plugins = {}

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

  vim.cmd("packadd! " .. name)

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
  local queue = {}

  -- Enqueue all plugins initially
  for name, _ in pairs(M.plugins) do
    table.insert(queue, name)
  end

  while #queue > 0 do
    local name = table.remove(queue, 1) -- Dequeue

    if not visited[name] then
      visited[name] = true

      local plugin = M.plugins[name]

      if not plugin then
        error("Plugin " .. name .. " not found")
      end

      -- Enqueue dependencies
      for _, dep_name in ipairs(plugin.depends or {}) do
        if not visited[dep_name] then
          table.insert(queue, dep_name)
        end
      end

      table.insert(sorted, name)
    end
  end

  -- Reverse the sorted list to maintain dependency order
  for i = 1, #sorted / 2 do
    sorted[i], sorted[#sorted - i + 1] = sorted[#sorted - i + 1], sorted[i]
  end

  return sorted
end

M.finish = function()
  vim.g.mapleader = " "

  -- disable netrw
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  for _, name in ipairs(M.sort_plugins()) do
    M.load_plugin(name)
  end

  vim.keymap.set(
    "n",
    "<leader>wv",
    "<cmd>vsplit<cr>",
    { noremap = true, silent = true, desc = "Split window vertically" }
  )
  vim.keymap.set(
    "n",
    "<leader>ws",
    "<cmd>split<cr>",
    { noremap = true, silent = true, desc = "Split window horizontally" }
  )
  vim.keymap.set("n", "<leader>wc", "<cmd>close<cr>", { noremap = true, silent = true, desc = "Close current window" })
  vim.keymap.set(
    "n",
    "<leader>wo",
    "<cmd>only<cr>",
    { noremap = true, silent = true, desc = "Close all windows except current" }
  )

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
  vim.opt.conceallevel = 2

  -- Set custom filetypes for some specific files
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "flake.lock", "Cargo.lock" },
    command = "set filetype=json",
  })
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "docker-compose.yml", "docker-compose.yaml" },
    command = "set filetype=yaml.docker-compose",
  })
end

return M
