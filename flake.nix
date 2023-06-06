{
  description = "A great neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nightvim = {
      url = "github:cfcosta/nightvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    cmp-buffer = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };
    cmp-cmdline = {
      url = "github:hrsh7th/cmp-cmdline";
      flake = false;
    };
    cmp-nvim-lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    cmp-path = {
      url = "github:hrsh7th/cmp-path";
      flake = false;
    };
    cmp-snippy = {
      url = "github:dcampos/cmp-snippy";
      flake = false;
    };
    codegpt = {
      url = "github:dpayne/codegpt.nvim";
      flake = false;
    };
    comment = {
      url = "github:numtostr/comment.nvim";
      flake = false;
    };
    diffview = {
      url = "github:sindrets/diffview.nvim";
      flake = false;
    };
    gitsigns = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
    lualine = {
      url = "github:nvim-lualine/lualine.nvim";
      flake = false;
    };
    neo-tree = {
      url = "github:nvim-neo-tree/neo-tree.nvim";
      flake = false;
    };
    neogit = {
      url = "github:TimUntersberger/neogit";
      flake = false;
    };
    neorg = {
      url = "github:nvim-neorg/neorg";
      flake = false;
    };
    nui = {
      url = "github:muniftanjim/nui.nvim";
      flake = false;
    };
    null-ls = {
      url = "github:jose-elias-alvarez/null-ls.nvim";
      flake = false;
    };
    nvim-autopairs = {
      url = "github:windwp/nvim-autopairs";
      flake = false;
    };
    nvim-cmp = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };
    nvim-dap = {
      url = "github:mfussenegger/nvim-dap";
      flake = false;
    };
    nvim-lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    nvim-snippy = {
      url = "github:dcampos/nvim-snippy";
      flake = false;
    };
    nvim-surround = {
      url = "github:kylechui/nvim-surround";
      flake = false;
    };
    nvim-treesitter = {
      url = "github:nvim-treesitter/nvim-treesitter";
      flake = false;
    };
    nvim-treesitter-endwise = {
      url = "github:RRethy/nvim-treesitter-endwise";
      flake = false;
    };
    nvim-web-devicons = {
      url = "github:nvim-tree/nvim-web-devicons";
      flake = false;
    };
    plenary = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    rust-tools = {
      url = "github:simrat39/rust-tools.nvim";
      flake = false;
    };
    telescope = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };
    toggleterm = {
      url = "github:akinsho/toggleterm.nvim";
      flake = false;
    };
    moonlight = {
      url = "github:shaunsingh/moonlight.nvim";
      flake = false;
    };
    trouble = {
      url = "github:folke/trouble.nvim";
      flake = false;
    };
    treesj = {
      url = "github:Wansmer/treesj";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, home-manager, nightvim, ... }:
    let
      vimConfig = { options, config, lib, pkgs, ... }: {
        imports = [ nightvim.hmModule ];

        programs.nightvim = {
          enable = true;

          extraConfig = builtins.readFile ./init.lua;

          plugins = with inputs; [
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
              depends = [ "plenary" "nvim-web-devicons" "nui" ];
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
              inputs = with pkgs; [ rnix-lsp ];

              config = ''
                local lspconfig = require('lspconfig')

                lspconfig.rnix.setup {}
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
            (nightvim.lib.mkPlugin "nvim-treesitter-endwise"
              nvim-treesitter-endwise { config = ""; })
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
          ];
        };
      };
    in {
      hmModule = vimConfig;
    } // flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        defaultPackage = (home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            vimConfig
            ({ options, config, lib, pkgs, ... }: {
              home.username = "nightvim";
              home.homeDirectory = if pkgs.stdenv.isLinux then
                "/home/nightvim"
              else
                "/Users/nightvim";

              home.stateVersion = "23.05";
            })
          ];
        }).activation-script;
      });
}
