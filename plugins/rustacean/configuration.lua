local executors = require("rustaceanvim.executors")
vim.g.rustaceanvim = function()
  return {
    tools = {
      executor = executors.toggleterm,
      test_executor = "neotest",
      crate_test_executor = "neotest",
      enable_clippy = true,
      enable_nextest = true,
    },
    server = {
      cmd = { "rust-analyzer" },

      on_attach = function(_, bufnr)
        vim.keymap.set("v", "<leader>j", function()
          vim.cmd.RustLsp("joinLines")
        end, { buffer = bufnr, desc = "rust: join lines" })
        vim.keymap.set("n", "<leader>cc", function()
          vim.cmd.RustLsp("codeAction")
        end, { buffer = bufnr, desc = "rust: code actions" })
        vim.keymap.set("n", "<leader>rT", function()
          vim.cmd.RustLsp({ "testables", bang = true })
        end, { buffer = bufnr, desc = "rust: run last ran test" })
        vim.keymap.set("n", "<leader>rd", function()
          vim.cmd.RustLsp("openDocs")
        end, { buffer = bufnr, desc = "rust: open rustdoc for symbol under cursor" })
        vim.keymap.set("n", "<leader>rh", function()
          vim.cmd.RustLsp({ "view", "hir" })
        end, { buffer = bufnr, desc = "rust: view HIR" })
        vim.keymap.set("n", "<leader>rm", function()
          vim.cmd.RustLsp({ "view", "mir" })
        end, { buffer = bufnr, desc = "rust: view MIR" })
        vim.keymap.set("n", "<leader>rr", function()
          vim.cmd.RustLsp({ "flyCheck", "run" })
        end, { buffer = bufnr, desc = "rust: run checks" })
        vim.keymap.set("n", "<leader>rt", function()
          vim.cmd.RustLsp({ "testables" })
        end, { buffer = bufnr, desc = "rust: run test" })
      end,

      settings = {
        ["rust-analyzer"] = {
          cargo = {
            buildScripts = { enable = true },
            allTargets = true,
          },
          hover = {
            actions = {
              implementations = true,
              references = true,
              run = true,
            },
          },
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },
          inlayHints = {
            bindingModeHints = { enable = true },
            closureCaptureHints = { enable = true },
            closureReturnTypeHints = { enable = "always" },
            genericParameterHints = {
              lifetime = {
                enable = true,
              },
              type = {
                enable = true,
              },
            },
            lifetimeElisionHints = {
              enable = "skip_trivial",
              useParameterNames = true,
            },
            maxLength = nil,
          },
          procMacro = { enable = true },
          rust = { analyzerTargetDir = true },
        },
      },
    },
  }
end
