local notify = require("notify")

notify.setup({
  render = "wrapped-compact",
  fps = 60,
  timeout = 600,
  max_width = 48,
  opacity = 20,
})

vim.notify = notify
