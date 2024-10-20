local executors = require("rustaceanvim.executors")
vim.g.rustaceanvim = function()
  return {
    tools = {
      executor = executors.toggleterm,
      enable_clippy = true,
      enable_nextest = true,
    },
    server = {
      cmd = { "rust-analyzer" },

      on_attach = function(_, bufnr)
        vim.keymap.set("n", "<leader>ca", function()
          vim.cmd.RustLsp("codeAction")
        end, {
          buffer = bufnr,
          desc = "rust: code actions",
        })
        vim.keymap.set("n", "<leader>cc", function()
          vim.cmd.RustLsp({ "hover", "actions" })
        end, {
          buffer = bufnr,
          desc = "rust: code actions",
        })
        vim.keymap.set("n", "<leader>rr", function()
          vim.cmd.RustLsp({ "flyCheck", "run" })
        end, {
          buffer = bufnr,
          desc = "rust: run checks",
        })
        vim.keymap.set("n", "<leader>rh", function()
          vim.cmd.RustLsp({ "view", "hir" })
        end, {
          buffer = bufnr,
          desc = "rust: view HIR",
        })
        vim.keymap.set("n", "<leader>rm", function()
          vim.cmd.RustLsp({ "view", "mir" })
        end, {
          buffer = bufnr,
          desc = "rust: view MIR",
        })
        vim.keymap.set("n", "<leader>rt", function()
          vim.cmd.RustLsp({ "testables" })
        end, {
          buffer = bufnr,
          desc = "rust: run test",
        })
        vim.keymap.set("n", "<leader>rT", function()
          vim.cmd.RustLsp({ "testables", bang = true })
        end, {
          buffer = bufnr,
          desc = "rust: run last ran test",
        })
      end,

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
