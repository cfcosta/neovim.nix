local none_ls = require("null-ls")

local sources = {
  none_ls.builtins.code_actions.refactoring,
  none_ls.builtins.diagnostics.actionlint,
  none_ls.builtins.diagnostics.deadnix,
  none_ls.builtins.diagnostics.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),
}

none_ls.setup({ sources = sources })
