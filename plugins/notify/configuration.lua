local notify = require("notify")

notify.setup({
  render = "wrapped-compact",
  fps = 30,
  timeout = 800,
  max_width = 48,
  opacity = 20,
})

vim.notify = notify
