local M = {}

M.plugins_root = vim.fn.stdpath("config") .. "/night/plugins"
M.afterHooks = {}
M.plugins = {
  lazy = {},
  eager = {},
}

M.init = function()
  vim.opt.packpath:prepend(M.plugins_root)
end

M.setup_plugin_eager = function(name, depends, config)
  M.plugins.eager[name] = { depends = depends, config = config, loaded = false }
end

M.setup_plugin = function(name, depends, config)
  M.plugins.lazy[name] = { depends = depends, config = config, loaded = false }
end

M.load_plugin = function(name)
  local plugin = M.plugins.eager[name] or M.plugins.lazy[name]

  if not plugin.loaded then
    for _, dep_name in ipairs(plugin.depends) do
      local dep = M.plugins.eager[dep_name] or M.plugins.lazy[dep_name]

      if not dep then
        error("Dependency " .. dep_name .. " not found")
      end

      M.load_plugin(dep_name)
    end

    plugin.config()

    local hook = M.afterHooks[name]

    if hook then
      hook()
    end

    plugin.loaded = true
  end
end

M.finish = function()
  for dep_name, _ in pairs(M.plugins.eager) do
    M.load_plugin(dep_name)
  end

  vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    once = true,
    callback = function()
      for dep_name, _ in pairs(M.plugins.lazy) do
        M.load_plugin(dep_name)
      end
    end,
  })
end

return M
