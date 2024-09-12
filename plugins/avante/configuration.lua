-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.opt.splitkeep = "screen"

require("avante_lib").load()

require("avante").setup({
  provider = "openai",
  auto_suggestion_provider = "openai",

  openai = {
    model = "o1-mini",
  },
})
