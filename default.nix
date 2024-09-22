{
  pkgs,
  deps,
  lib,
  ...
}:
let
  inherit (builtins) readFile isPath;
  inherit (pkgs.stdenv) mkDerivation;

  mkPlugin =
    a@{
      name,
      src,
      depends ? [ ],
      inputs ? [ ],
      module ? name,
      config ? ''require("${a.module or name}").setup {}'',
      ...
    }:
    mkDerivation {
      inherit src;
      name = "nightvim-${name}";
      version = src.shortRev or "dev-nightvim";

      nativeBuildInputs = inputs;

      dontBuild = true;
      installPhase = ''
        mkdir -p $out/pack/nightvim/start/${name}
        cp -r . $out/pack/nightvim/start/${name}
      '';

      passthru = {
        inherit
          name
          depends
          inputs
          module
          ;
        config = if isPath config then readFile config else config;

        paths = inputs;
      };
    };

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
    (importPlugin ./plugins/autopairs)
    (importPlugin ./plugins/avante)
    (importPlugin ./plugins/catppuccin)
    (importPlugin ./plugins/cmp)
    (importPlugin ./plugins/conform)
    (importPlugin ./plugins/grug-far)
    (importPlugin ./plugins/indent-blankline)
    (importPlugin ./plugins/lspconfig)
    (importPlugin ./plugins/lualine)
    (importPlugin ./plugins/neo-tree)
    (importPlugin ./plugins/neogit)
    (importPlugin ./plugins/nvim-web-devicons)
    (importPlugin ./plugins/octo)
    (importPlugin ./plugins/rustacean)
    (importPlugin ./plugins/surround)
    (importPlugin ./plugins/telescope)
    (importPlugin ./plugins/toggleterm)
    (importPlugin ./plugins/treesitter)
    (importPlugin ./plugins/treesj.nix)
    (importPlugin ./plugins/trouble)
    (importPlugin ./plugins/wakatime)

    (mkPlugin {
      name = "comment";
      src = deps.comment;
      module = "Comment";
    })
    (mkPlugin {
      name = "lspkind";
      src = deps.lspkind;
      config = "";
    })
    (mkPlugin {
      name = "cmp-buffer";
      src = deps.cmp-buffer;
      config = "";
    })
    (mkPlugin {
      name = "cmp-cmdline";
      src = deps.cmp-cmdline;
      config = "";
    })
    (mkPlugin {
      name = "cmp-nvim-lsp";
      src = deps.cmp-nvim-lsp;
      config = "";
    })
    (mkPlugin {
      name = "cmp-path";
      src = deps.cmp-path;
      config = "";
    })
    (mkPlugin {
      name = "cmp-snippy";
      src = deps.cmp-snippy;
      config = "";
    })
    (mkPlugin {
      name = "diffview";
      src = deps.diffview;
    })
    (mkPlugin {
      name = "gitsigns";
      src = deps.gitsigns;
    })
    (mkPlugin {
      name = "nui";
      src = deps.nui;
      config = "";
    })
    (mkPlugin {
      name = "dressing";
      src = deps.dressing;
      config = "";
    })
    (mkPlugin {
      name = "nvim-dap";
      src = deps.nvim-dap;
      config = "";
    })
    (mkPlugin {
      name = "nvim-snippy";
      src = deps.nvim-snippy;
      config = "";
    })
    (mkPlugin {
      name = "nvim-treesitter-endwise";
      src = deps.nvim-treesitter-endwise;
      config = "";
    })
    (mkPlugin {
      name = "nvim-treesitter-just";
      src = deps.nvim-treesitter-just;
      config = "";
    })
    (mkPlugin {
      name = "plenary";
      src = deps.plenary;
      config = "";
    })
    (mkPlugin {
      name = "aiken-neovim";
      src = deps.aiken-neovim;
      config = "";
    })
    (mkPlugin {
      name = "which-key";
      src = deps.which-key;
    })
    (mkPlugin {
      name = "zen-mode";
      src = deps.zen-mode;
    })
  ];
}
