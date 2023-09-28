if not os.getenv("NVIM_CONFIG_IN_TEST") then
  require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
  })
end
