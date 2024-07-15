local NV = {
  root = vim.fn.stdpath("config") .. "/night",
  plugins_root = vim.fn.stdpath("config") .. "/night/plugins",
  afterHooks = {},
  plugins = {
    lazy = {},
    eager = {},
  },
}

local function _nv_open_config()
  local config_home = os.getenv("XDG_CONFIG_HOME")

  if config_home == nil or config_home == "" then
    config_home = os.getenv("HOME") .. "/.config"
  end

  local config_path = config_home .. "/nvim/init.lua"

  vim.cmd("edit " .. config_path)
end

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

local function _nv_init()
  vim.opt.packpath:prepend(NV.plugins_root)

  -- Add a command to open the currently generated config
  vim.cmd("command! NightVimOpenConfig lua _nv_open_config()")
end

local function _nv_setup_plugin_eager(name, depends, config)
  NV.plugins.eager[name] = { depends = depends, config = config, loaded = false }
end

local function _nv_setup_plugin(name, depends, config)
  NV.plugins.lazy[name] = { depends = depends, config = config, loaded = false }
end

local function after(name, func)
  NV.afterHooks[name] = func
end

local function nv_load_plugin(name)
  local plugin = NV.plugins.eager[name] or NV.plugins.lazy[name]

  if not plugin.loaded then
    for _, dep_name in ipairs(plugin.depends) do
      local dep = NV.plugins.eager[dep_name] or NV.plugins.lazy[dep_name]

      if not dep then
        error("Dependency " .. dep_name .. " not found")
      end

      nv_load_plugin(dep_name)
    end

    plugin.config()

    local hook = NV.afterHooks[name]

    if hook then
      hook()
    end

    plugin.loaded = true
  end
end

local function _nv_finish()
  for k, _ in pairs(NV.plugins.eager) do
    nv_load_plugin(k)
  end

  vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    once = true,
    callback = function()
      for k, _ in pairs(NV.plugins.lazy) do
        nv_load_plugin(k)
      end
    end,
  })
end
