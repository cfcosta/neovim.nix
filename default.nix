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
      lazy = true;
    }
    // spec;

  mkPlugin =
    specs@{
      name,
      src,
      config,
      depends ? [ ],
      inputs ? [ ],
      lazy ? true,
      module ? name,
    }:
    {
      inherit
        name
        src
        depends
        inputs
        lazy
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
    (importPlugin ./plugins/grug-far)
    (importPlugin ./plugins/lspconfig)
    (importPlugin ./plugins/neo-tree)
    (importPlugin ./plugins/telescope)
    (importPlugin ./plugins/toggleterm)
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
    (mkPlugin' "nvim-cmp" deps.nvim-cmp {
      depends = [
        "cmp-buffer"
        "cmp-cmdline"
        "cmp-nvim-lsp"
        "cmp-path"
        "cmp-snippy"
        "lspkind"
        "nvim-dap"
        "nvim-lspconfig"
        "nvim-snippy"
        "plenary"
      ];

      config = readFile ./plugins/cmp.lua;
    })
    (mkPlugin' "rustacean" deps.rustacean {
      lazy = false;
      config = readFile ./plugins/rustacean.lua;
    })
    (mkPlugin' "catpuccin" deps.catpuccin {
      lazy = false;
      config = readFile ./plugins/colorscheme.lua;
    })
    (mkPlugin' "lualine" deps.lualine {
      depends = [ "nvim-web-devicons" ];
      config = "";
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
    (mkPlugin' "nvim-surround" deps.nvim-surround { })
    (mkPlugin' "nvim-treesitter-endwise" deps.nvim-treesitter-endwise { config = ""; })
    (mkPlugin' "nvim-treesitter-just" deps.nvim-treesitter-just { config = ""; })
    (mkPlugin' "nvim-web-devicons" deps.nvim-web-devicons { })
    (mkPlugin' "plenary" deps.plenary { config = ""; })
    (mkPlugin' "treesj" deps.treesj { })
    (mkPlugin' "aiken-neovim" deps.aiken-neovim { config = ""; })
    (mkPlugin' "wakatime" deps.wakatime {
      inputs = [ pkgs.wakatime ];
      config = ''
        vim.g.wakatime_CLIPath = "${pkgs.wakatime}/bin/wakatime-cli"
        ${readFile ./plugins/wakatime.lua}
      '';
      lazy = false;
    })
    (mkPlugin' "which-key" deps.which-key { })
    (mkPlugin' "zen-mode" deps.zen-mode { })

  ];
}
