local lspconfig = require "lspconfig"

lspconfig.rnix.setup {}
lspconfig.tsserver.setup {}
lspconfig.eslint.setup {}
lspconfig.svelte.setup {}

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
