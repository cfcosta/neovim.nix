-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.opt.splitkeep = "screen"

require("avante_lib").load()

require("avante").setup({
  provider = os.getenv("AVANTE_PROVIDER") or "claude",
  auto_suggestion_provider = os.getenv("AVANTE_AUTO_SUGGESTION_PROVIDER") or "openai",

  claude = {
    model = os.getenv("AVANTE_CLAUDE_MODEL") or "claude-3-5-sonnet-20240620",
  },
  openai = {
    model = os.getenv("AVANTE_OPENAI_MODEL") or "gpt4o-mini",
  },
})
