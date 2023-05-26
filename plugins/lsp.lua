return function()
  require("mason").setup()
  require("mason-lspconfig").setup()

  local lspconfig = require "lspconfig"

  lspconfig.lua_ls.setup {}
  lspconfig.rust_analyzer.setup {}
  lspconfig.docker_compose_language_service.setup {}
  lspconfig.gopls.setup {}
  lspconfig.jsonls.setup {}
end
