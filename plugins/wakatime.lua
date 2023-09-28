if os.getenv("NVIM_CONFIG_IN_TEST") then
  vim.g.loaded_wakatime = 1
end

vim.g.wakatime_CLIPath = string.gsub(vim.fn.system("which wakatime-cli"), "[\n\r]", "")
