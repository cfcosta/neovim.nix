local none_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local sources = {
  none_ls.builtins.code_actions.refactoring,
  none_ls.builtins.code_actions.statix,
  none_ls.builtins.diagnostics.actionlint,
  none_ls.builtins.diagnostics.deadnix,
  none_ls.builtins.diagnostics.luacheck,
  none_ls.builtins.diagnostics.ruff,
  none_ls.builtins.diagnostics.shellcheck,
  none_ls.builtins.diagnostics.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),
  none_ls.builtins.formatting.clang_format,
  none_ls.builtins.formatting.cmake_format,
  none_ls.builtins.formatting.jq,
  none_ls.builtins.formatting.nixfmt,
  none_ls.builtins.formatting.ruff,
  none_ls.builtins.formatting.rustfmt,
  none_ls.builtins.formatting.shfmt,
  none_ls.builtins.formatting.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),
  none_ls.builtins.formatting.stylua,
}

none_ls.setup({
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
