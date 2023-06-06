{ pkgs, deps, ... }: {
  programs.nightvim.plugins = with deps; [
    (nightvim.lib.mkPlugin "codegpt" codegpt {
      depends = [ "nui" "plenary" ];
      config = ''
        if os.getenv "OPENAI_API_KEY" then
          require "codegpt.config"
        end
      '';
    })
    (nightvim.lib.mkPlugin "comment" comment {
      config = ''
        require("Comment").setup {}
      '';
    })
    (nightvim.lib.mkPlugin "diffview" diffview { })
    (nightvim.lib.mkPlugin "gitsigns" gitsigns { })
    (nightvim.lib.mkPlugin "neo-tree" neo-tree {
      depends = [ "plenary" "nvim-web-devicons" "nui" "moonlight" ];
      config = ''
        vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]
        require("neo-tree").setup()
      '';
    })
    (nightvim.lib.mkPlugin "neogit" neogit {
      depends = [ "plenary" "diffview" ];
      config = ''
        require("neogit").setup {
          use_magit_keybindings = true,
          integrations = {
            diffview = true,
          },
        }
      '';
    })
    (nightvim.lib.mkPlugin "neorg" neorg {
      config = ''
        require("neorg").setup {
          load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {},
            ["core.dirman"] = {
              config = {
                workspaces = {
                  notes = "~/Notes",
                },
                default_workspace = "notes",
              },
            },
          },
        }
      '';
    })
    (nightvim.lib.mkPlugin "nvim-web-devicons" nvim-web-devicons { })
    (nightvim.lib.mkPlugin "nui" nui { config = ""; })
    (nightvim.lib.mkPlugin "null-ls" null-ls {
      depends = [ "plenary" "nvim-lspconfig" ];

      inputs = with pkgs; [
        actionlint
        nixfmt
        nodePackages.eslint
        shellcheck
        shfmt
        statix
        stylua
      ];

      config = ''
        local null_ls = require "null-ls"
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        null_ls.setup {
          sources = {
            null_ls.builtins.code_actions.statix,
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.eslint,
            null_ls.builtins.formatting.rustfmt,
            null_ls.builtins.formatting.nixfmt,
            null_ls.builtins.formatting.shfmt,
            null_ls.builtins.diagnostics.actionlint,
            null_ls.builtins.diagnostics.shellcheck,
            null_ls.builtins.diagnostics.eslint,
          },
          on_attach = function(client, bufnr)
            if client.supports_method "textDocument/formatting" then
              vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format { bufnr = bufnr }
                end,
              })
            end
          end,
        }
      '';
    })
    (nightvim.lib.mkPlugin "nvim-autopairs" nvim-autopairs {
      config = ''
        require("nvim-autopairs").setup({
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        })
      '';
    })
    (nightvim.lib.mkPlugin "nvim-cmp" nvim-cmp {
      depends = [
        "cmp-buffer"
        "cmp-cmdline"
        "cmp-nvim-lsp"
        "cmp-path"
        "cmp-snippy"
        "nvim-dap"
        "nvim-lspconfig"
        "nvim-snippy"
        "plenary"
        "neorg"
      ];

      config = ''
        local cmp = require("cmp")

        cmp.setup {
              snippet = {
                expand = function(args)
                  require("snippy").expand_snippet(args.body)
                end,
              },
              window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
              },
              mapping = cmp.mapping.preset.insert {
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm { select = true },
              },
              sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "snippy" },
                { name = "neorg" },
              }, {
                { name = "buffer" },
              }),
            }
      '';
    })
    (nightvim.lib.mkPlugin "nvim-dap" nvim-dap { config = ""; })
    (nightvim.lib.mkPlugin "nvim-lspconfig" nvim-lspconfig {
      inputs = with pkgs; [
        rnix-lsp
        nodePackages.eslint
        nodePackages.svelte-language-server
        nodePackages.typescript
        nodePackages.typescript-language-server
        nodePackages.vscode-langservers-extracted
      ];

      config = ''
        local lspconfig = require('lspconfig')

        lspconfig.rnix.setup {}
        lspconfig.tsserver.setup {}
        lspconfig.eslint.setup {}
        lspconfig.svelte.setup {}
      '';
    })
    (nightvim.lib.mkPlugin "nvim-snippy" nvim-snippy { config = ""; })
    (nightvim.lib.mkPlugin "nvim-surround" nvim-surround { })
    (nightvim.lib.mkPlugin "plenary" plenary { config = ""; })
    (nightvim.lib.mkPlugin "rust-tools" rust-tools {
      inputs = with pkgs; [ rust-analyzer ];
    })
    (nightvim.lib.mkPlugin "cmp-buffer" cmp-buffer { config = ""; })
    (nightvim.lib.mkPlugin "cmp-cmdline" cmp-cmdline { config = ""; })
    (nightvim.lib.mkPlugin "cmp-nvim-lsp" cmp-nvim-lsp { config = ""; })
    (nightvim.lib.mkPlugin "cmp-path" cmp-path { config = ""; })
    (nightvim.lib.mkPlugin "cmp-snippy" cmp-snippy { config = ""; })
    (nightvim.lib.mkPlugin "moonlight" moonlight {
      config = ''
        require("moonlight").set()
      '';
    })
    (nightvim.lib.mkPlugin "toggleterm" toggleterm { })
    (nightvim.lib.mkPlugin "telescope" telescope {
      inputs = with pkgs; [ ripgrep ];

      config = ''
        local options = {
          defaults = {
            vimgrep_arguments = {
              "rg",
              "-L",
              "--color=never",
              "--no-heading",
              "--with-filename",
              "--line-number",
              "--column",
              "--smart-case",
            },
            prompt_prefix = " >  ",
            selection_caret = "  ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
              horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
              },
              vertical = {
                mirror = false,
              },
              width = 0.87,
              height = 0.80,
              preview_cutoff = 120,
            },
            file_sorter = require("telescope.sorters").get_fuzzy_file,
            file_ignore_patterns = { "node_modules", ".git" },
            generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            path_display = { "truncate" },
            winblend = 0,
            border = {},
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            color_devicons = true,
            set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
            file_previewer = require("telescope.previewers").vim_buffer_cat.new,
            grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
            qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
            buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
            mappings = {
              n = { ["q"] = require("telescope.actions").close },
            },
          },

          extensions_list = { "themes", "terms" },
        }

        require("telescope").setup(options)
      '';
    })
    (nightvim.lib.mkPlugin "trouble" trouble {
      depends = [ "nvim-web-devicons" ];
    })
    (nightvim.lib.mkPlugin "lualine" lualine {
      depends = [ "nvim-web-devicons" "moonlight" ];
      config = ''
        require("lualine").setup {
          options = {
            theme = "moonlight",
          }
        }
      '';
    })
    (nightvim.lib.mkPlugin "nvim-treesitter-endwise" nvim-treesitter-endwise {
      config = "";
    })
    (nightvim.lib.mkPlugin "nvim-treesitter" nvim-treesitter {
      depends = [ "nvim-treesitter-endwise" ];

      inputs = with pkgs; [ gcc git ];

      config = ''
        local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
        vim.fn.mkdir(parser_install_dir, "p")
        vim.opt.runtimepath:append(parser_install_dir)

        require("nvim-treesitter.configs").setup {
          ensure_installed = { "rust", "nix" },
          sync_install = false,
          auto_install = true,
          highlight = { enable = true },
          endwise = { enable = true },
          indent = { enable = true },
          parser_install_dir = parser_install_dir,
        }

        -- Enable folding using treesitter
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        vim.opt.foldenable = false
      '';
    })
    (nightvim.lib.mkPlugin "treesj" treesj { })
    (nightvim.lib.mkPlugin "indent-blankline" indent-blankline {
      depends = [ "moonlight" ];

      config = ''
        vim.cmd [[highlight IndentBlanklineIndent1 guifg=#282D45 gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent2 guifg=#2F3552 gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent3 guifg=#373D5E gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent4 guifg=#3E466B gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent5 guifg=#464E78 gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent6 guifg=#4D5685 gui=nocombine]]

        require("indent_blankline").setup {
          filetype_exclude = {
            "help",
            "terminal",
            "lspinfo",
            "TelescopePrompt",
            "TelescopeResults",
            "",
          },
          buftype_exclude = { "terminal" },
          show_trailing_blankline_indent = false,
          show_first_indent_level = false,
          show_current_context = true,
          show_current_context_start = true,
          char_highlight_list = {
            "IndentBlanklineIndent1",
            "IndentBlanklineIndent2",
            "IndentBlanklineIndent3",
            "IndentBlanklineIndent4",
            "IndentBlanklineIndent5",
            "IndentBlanklineIndent6",
          },
        }
      '';
    })
  ];
}
