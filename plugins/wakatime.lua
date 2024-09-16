-- If Wakatime is not configured, do not load the plugin
local cfg_exists = io.open(os.getenv("HOME") .. "/.wakatime.cfg", "r") ~= nil
vim.g.loaded_wakatime = cfg_exists and 0 or 1
