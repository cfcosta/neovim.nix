local on_attach = function(client, _)
  if not client.supports_method("textDocument/formatting") then
    return
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp", { clear = true }),
    callback = function(args)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ async = false, id = args.data.client_id })
        end,
      })
    end,
  })
end

vim.g.rustaceanvim = function()
  return {
    server = {
      on_attach = on_attach,

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
