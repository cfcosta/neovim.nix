vim.g.rustaceanvim = function()
  return {
    server = {
      cmd = { "rust-analyzer" },

      settings = {
        ["rust-analyzer"] = {
          cargo = {
            buildScripts = { enable = true },
            allTargets = false,
          },
          hover = {
            actions = {
              implementations = true,
              references = true,
              run = true,
            },
          },
          imports = { preferPrelude = true },
          inlayHints = {
            maxLength = nil,
            lifetimeElisionHints = {
              useParameterNames = true,
              enable = "skip_trivial",
            },
            closureReturnTypeHints = { enable = "always" },
          },
          procMacro = { enable = true },
          rust = { analyzerTargetDir = true },
        },
      },
    },
  }
end
