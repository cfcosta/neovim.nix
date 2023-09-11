local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp_attach = function(client, buf)
  vim.api.nvim_buf_set_option(buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.api.nvim_buf_set_option(buf, "tagfunc", "v:lua.vim.lsp.tagfunc")
end

-- Setup rust_analyzer via rust-tools.nvim
require("rust-tools").setup({
  server = {
    capabilities = capabilities,
    on_attach = lsp_attach,
    settings = {
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      checkOnSave = {
        command = "clippy",
      },
      procMacro = {
        enable = true,
        ignored = {
          ["async-trait"] = { "async-trait" },
        },
      },
    },
  },
})
