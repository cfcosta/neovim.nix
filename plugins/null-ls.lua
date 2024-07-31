local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.code_actions.statix,                                                     -- Nix
    null_ls.builtins.code_actions.eslint,                                                     -- JS/TS

    null_ls.builtins.formatting.clang_format,                                                 -- C/C++
    null_ls.builtins.formatting.cmake_format,                                                 -- CMake
    null_ls.builtins.formatting.eslint,                                                       -- JS/TS
    null_ls.builtins.formatting.jq,                                                           -- JSON
    null_ls.builtins.formatting.nixfmt,                                                       -- Nix
    null_ls.builtins.formatting.ruff,                                                         -- Python
    null_ls.builtins.formatting.rustfmt,                                                      -- Rust
    null_ls.builtins.formatting.shfmt,                                                        -- Shell
    null_ls.builtins.formatting.stylua,                                                       -- Lua
    null_ls.builtins.formatting.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),  -- PostgreSQL

    null_ls.builtins.diagnostics.actionlint,                                                  -- Github Actions
    null_ls.builtins.diagnostics.eslint,                                                      -- JS/TS
    null_ls.builtins.diagnostics.ruff,                                                        -- Python
    null_ls.builtins.diagnostics.shellcheck,                                                  -- Shell
    null_ls.builtins.diagnostics.deadnix,                                                     -- Nix
    null_ls.builtins.diagnostics.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }), -- PostgreSQL
  },
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
