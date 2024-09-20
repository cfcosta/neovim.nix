{
  pkgs,
  deps,
  lib,
  ...
}:
let
  inherit (builtins) readFile isPath;

  # Legacy mkPlugin for non-migrated ones
  # TODO: Remove
  mkPlugin' =
    name: src: spec:
    rec {
      inherit name src;
      depends = [ ];
      inputs = [ ];
      config = ''require("${module}").setup {}'';
      module = name;
    }
    // spec;

  mkPlugin =
    specs@{
      name,
      src,
      config,
      depends ? [ ],
      inputs ? [ ],
      module ? name,
    }:
    {
      inherit
        name
        src
        depends
        inputs
        module
        ;

      config = if isPath config then readFile config else config;
    }
    // specs;

  importPlugin =
    dir:
    import dir {
      inherit
        pkgs
        deps
        mkPlugin
        lib
        ;
    };
in
{
  programs.nightvim.plugins = [
    (importPlugin ./plugins/avante)
    (importPlugin ./plugins/catppuccin)
    (importPlugin ./plugins/cmp)
    (importPlugin ./plugins/conform)
    (importPlugin ./plugins/grug-far)
    (importPlugin ./plugins/lspconfig)
    (importPlugin ./plugins/lualine)
    (importPlugin ./plugins/neo-tree)
    (importPlugin ./plugins/nvim-web-devicons)
    (importPlugin ./plugins/rustacean)
    (importPlugin ./plugins/surround)
    (importPlugin ./plugins/telescope)
    (importPlugin ./plugins/toggleterm)
    (importPlugin ./plugins/treesj)
    (importPlugin ./plugins/trouble)

    (mkPlugin' "comment" deps.comment { config = ''require("Comment").setup {}''; })
    (mkPlugin' "neogit" deps.neogit {
      depends = [
        "plenary"
        "diffview"
      ];
      config = readFile ./plugins/neogit.lua;
    })
    (mkPlugin' "nvim-autopairs" deps.nvim-autopairs {
      config = ''
        require("nvim-autopairs").setup({
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        })
      '';
    })
    (mkPlugin' "nvim-treesitter" deps.nvim-treesitter {
      depends = [ "nvim-treesitter-endwise" ];
      inputs = with pkgs; [
        gcc
        git
      ];
      config = readFile ./plugins/treesitter.lua;
    })
    (mkPlugin' "indent-blankline" deps.indent-blankline { config = readFile ./plugins/indentline.lua; })
    (mkPlugin' "lspkind" deps.lspkind { config = ""; })
    (mkPlugin' "cmp-buffer" deps.cmp-buffer { config = ""; })
    (mkPlugin' "cmp-cmdline" deps.cmp-cmdline { config = ""; })
    (mkPlugin' "cmp-nvim-lsp" deps.cmp-nvim-lsp { config = ""; })
    (mkPlugin' "cmp-path" deps.cmp-path { config = ""; })
    (mkPlugin' "cmp-snippy" deps.cmp-snippy { config = ""; })
    (mkPlugin' "diffview" deps.diffview { })
    (mkPlugin' "gitsigns" deps.gitsigns { })
    (mkPlugin' "nui" deps.nui { config = ""; })
    (mkPlugin' "dressing" deps.dressing { config = ""; })
    (mkPlugin' "nvim-dap" deps.nvim-dap { config = ""; })
    (mkPlugin' "nvim-snippy" deps.nvim-snippy { config = ""; })
    (mkPlugin' "nvim-treesitter-endwise" deps.nvim-treesitter-endwise { config = ""; })
    (mkPlugin' "nvim-treesitter-just" deps.nvim-treesitter-just { config = ""; })
    (mkPlugin' "plenary" deps.plenary { config = ""; })
    (mkPlugin' "aiken-neovim" deps.aiken-neovim { config = ""; })
    (mkPlugin' "wakatime" deps.wakatime {
      inputs = [ pkgs.wakatime ];
      config = ''
        vim.g.wakatime_CLIPath = "${pkgs.wakatime}/bin/wakatime-cli"
        ${readFile ./plugins/wakatime.lua}
      '';
    })
    (mkPlugin' "which-key" deps.which-key { })
    (mkPlugin' "zen-mode" deps.zen-mode { })

  ];
}
