require("avante_lib").load()

require("avante").setup({
  provider = "claude",
  auto_suggestions_provider = "openai",
  providers = {
    claude = {
      model = "claude-opus-4-20250514",
    },
  },
  mappings = {
    suggestion = {
      accept = "<Tab>",
    },
  },
})
