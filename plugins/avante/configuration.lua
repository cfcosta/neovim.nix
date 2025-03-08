require("avante_lib").load()

require("avante").setup({
  provider = "claude",
  auto_suggestions_provider = "openai",
  claude = {
    model = "claude-3-7-sonnet-latest",
  },
  behaviour = {
    auto_suggestions = false,
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = false,
    minimize_diff = true,
  },
  mappings = {
    suggestion = {
      accept = "<Tab>",
    },
  },
})
