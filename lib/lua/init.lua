local M = {}

M.plugins = {}

local function has_values(tbl)
  return tbl and next(tbl) ~= nil
end

local function normalize_modes(mode)
  if type(mode) == "table" then
    return mode
  end

  return { mode or "n" }
end

M.setup_plugin = function(name, depends, config, lazy)
  M.plugins[name] = {
    depends = depends,
    config = config,
    lazy = lazy or {},
    loaded = false,
  }
end

M.load_plugin = function(name)
  local plugin = M.plugins[name]

  if not plugin then
    error("Plugin " .. name .. " not found")
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

  for name, _ in pairs(M.plugins) do
    table.insert(queue, name)
  end

  while #queue > 0 do
    local name = table.remove(queue, 1)

    if not visited[name] then
      visited[name] = true

      local plugin = M.plugins[name]

      if not plugin then
        error("Plugin " .. name .. " not found")
      end

      for _, dep_name in ipairs(plugin.depends or {}) do
        if not visited[dep_name] then
          table.insert(queue, dep_name)
        end
      end

      table.insert(sorted, name)
    end
  end

  for i = 1, #sorted / 2 do
    sorted[i], sorted[#sorted - i + 1] = sorted[#sorted - i + 1], sorted[i]
  end

  return sorted
end

M.is_lazy = function(plugin)
  return has_values(plugin.lazy)
end

M.replay_keys = function(lhs)
  local keys = vim.api.nvim_replace_termcodes(lhs, true, false, true)
  vim.api.nvim_feedkeys(keys, "m", false)
end

M.register_lazy_filetypes = function(name, filetypes)
  if not has_values(filetypes) then
    return
  end

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("NightvimLazyFt_" .. name, { clear = true }),
    once = true,
    pattern = filetypes,
    callback = function()
      M.load_plugin(name)
    end,
  })
end

M.register_lazy_keys = function(name, keys)
  if not has_values(keys) then
    return
  end

  for _, key in ipairs(keys) do
    vim.keymap.set(key.mode or "n", key.lhs, function()
      for _, mode in ipairs(normalize_modes(key.mode)) do
        pcall(vim.keymap.del, mode, key.lhs)
      end

      M.load_plugin(name)
      vim.schedule(function()
        M.replay_keys(key.lhs)
      end)
    end, {
      desc = key.desc,
      noremap = true,
      silent = true,
    })
  end
end

M.register_lazy_commands = function(name, commands)
  if not has_values(commands) then
    return
  end

  for _, command_name in ipairs(commands) do
    vim.api.nvim_create_user_command(command_name, function(opts)
      pcall(vim.api.nvim_del_user_command, command_name)
      M.load_plugin(name)

      local prefix = ""
      if opts.count and opts.count > 0 then
        prefix = tostring(opts.count)
      end

      local command = prefix .. command_name .. (opts.bang and "!" or "")
      if opts.args ~= "" then
        command = command .. " " .. opts.args
      end

      vim.cmd(command)
    end, {
      bang = true,
      count = true,
      nargs = "*",
    })
  end
end

M.register_lazy_plugin = function(name)
  local plugin = M.plugins[name]

  if not plugin or not M.is_lazy(plugin) then
    return
  end

  M.register_lazy_filetypes(name, plugin.lazy.ft)
  M.register_lazy_keys(name, plugin.lazy.keys)
  M.register_lazy_commands(name, plugin.lazy.cmd)
end

M.finish = function()
  vim.g.mapleader = " "

  -- disable netrw
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- Disable Unused providers (for faster boot)
  vim.g.loaded_node_provider = 0
  vim.g.loaded_perl_provider = 0
  vim.g.loaded_python3_provider = 0
  vim.g.loaded_ruby_provider = 0

  for _, name in ipairs(M.sort_plugins()) do
    M.register_lazy_plugin(name)
  end

  for _, name in ipairs(M.sort_plugins()) do
    if not M.is_lazy(M.plugins[name]) then
      M.load_plugin(name)
    end
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
    pattern = { "*.agda" },
    command = "set filetype=agda",
  })
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "flake.lock" },
    command = "set filetype=json",
  })
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "Cargo.lock" },
    command = "set filetype=toml",
  })
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "docker-compose.yml", "docker-compose.yaml" },
    command = "set filetype=yaml.docker-compose",
  })

  -- When inside a jujutsu repository, update working tree on save.
  --
  -- Everything runs inside a background job, we don't care about
  -- the result, just to commit to the working copy.
  vim.api.nvim_create_augroup("JujutsuAuto", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = "JujutsuAuto",
    callback = function()
      vim.fn.jobstart("jj workspace root --ignore-working-copy && jj status", { detach = true })
    end,
  })
end

return M
