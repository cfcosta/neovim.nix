{
  inputs,
  lib,
  pkgs,
  stdenv,
  symlinkJoin,
  ...
}:
let
  inherit (builtins) readFile isPath;
  inherit (stdenv) mkDerivation;

  mkPlugin' =
    {
      name,
      src,
      module ? name,
      config ? ''require("${module}").setup {}'',
      inputs ? [ ],
      depends ? [ ],
      ...
    }:
    mkDerivation {
      inherit src;
      name = "nightvim-${name}";
      version = src.shortRev or "dev-nightvim";

      dontBuild = true;
      installPhase = ''
        mkdir -p $out/share/nightvim/pack/nightvim/start/${name}
        cp -r . $out/share/nightvim/pack/nightvim/start/${name}
      '';

      passthru.spec = {
        inherit
          name
          src
          module
          inputs
          depends
          ;

        config = if isPath config then readFile config else config;
      };
    };

  mkPlugin =
    args@{
      inputs ? [ ],
      ...
    }:
    let
      plugin = mkPlugin' args;
    in
    symlinkJoin {
      name = "${args.name}-with-tools";
      paths = [ plugin ] ++ inputs;
      inherit (plugin) passthru;
    };

  importPlugin =
    dir:
    import dir {
      inherit
        pkgs
        inputs
        mkPlugin
        lib
        ;
    };
in
symlinkJoin rec {
  name = "nightvim-plugins";

  paths = [
    (importPlugin ./autopairs)
    (importPlugin ./avante)
    (importPlugin ./catppuccin)
    (importPlugin ./cmp)
    (importPlugin ./conform)
    (importPlugin ./grug-far)
    (importPlugin ./indent-blankline)
    (importPlugin ./lspconfig)
    (importPlugin ./lualine)
    (importPlugin ./neo-tree)
    (importPlugin ./neogit)
    (importPlugin ./nvim-web-devicons)
    (importPlugin ./octo)
    (importPlugin ./rustacean)
    (importPlugin ./surround)
    (importPlugin ./telescope)
    (importPlugin ./toggleterm)
    (importPlugin ./treesitter)
    (importPlugin ./treesj.nix)
    (importPlugin ./trouble)
    (importPlugin ./twilight)
    (importPlugin ./wakatime)
    (importPlugin ./zen-mode)

    (mkPlugin {
      name = "aiken-neovim";
      src = inputs.aiken-neovim;
      config = "";
    })
    (mkPlugin {
      name = "cmp-buffer";
      src = inputs.cmp-buffer;
      config = "";
    })
    (mkPlugin {
      name = "cmp-cmdline";
      src = inputs.cmp-cmdline;
      config = "";
    })
    (mkPlugin {
      name = "cmp-nvim-lsp";
      src = inputs.cmp-nvim-lsp;
      config = "";
    })
    (mkPlugin {
      name = "cmp-path";
      src = inputs.cmp-path;
      config = "";
    })
    (mkPlugin {
      name = "cmp-snippy";
      src = inputs.cmp-snippy;
      config = "";
    })
    (mkPlugin {
      name = "comment";
      src = inputs.comment;
      module = "Comment";
    })
    (mkPlugin {
      name = "diffview";
      src = inputs.diffview;
    })
    (mkPlugin {
      name = "dressing";
      src = inputs.dressing;
      config = "";
    })
    (mkPlugin {
      name = "gitsigns";
      src = inputs.gitsigns;
    })
    (mkPlugin {
      name = "lspkind";
      src = inputs.lspkind;
      config = "";
    })
    (mkPlugin {
      name = "nui";
      src = inputs.nui;
      config = "";
    })
    (mkPlugin {
      name = "nvim-dap";
      src = inputs.nvim-dap;
      config = "";
    })
    (mkPlugin {
      name = "nvim-snippy";
      src = inputs.nvim-snippy;
      config = "";
    })
    (mkPlugin {
      name = "nvim-treesitter-endwise";
      src = inputs.nvim-treesitter-endwise;
      config = "";
    })
    (mkPlugin {
      name = "nvim-treesitter-just";
      src = inputs.nvim-treesitter-just;
      config = "";
    })
    (mkPlugin {
      name = "plenary";
      src = inputs.plenary;
      config = "";
    })
    (mkPlugin {
      name = "which-key";
      src = inputs.which-key;
    })
  ];

  passthru.specs = map (p: p.spec) paths;
}
