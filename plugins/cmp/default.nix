{
  inputs,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "cmp";

  src = inputs.nvim-cmp;

  depends = [
    "cmp-buffer"
    "cmp-cmdline"
    "cmp-nvim-lsp"
    "cmp-path"
    "cmp-snippy"
    "lspconfig"
    "lspkind"
    "nvim-dap"
    "nvim-snippy"
    "plenary"
  ];

  config = readFile ./configuration.lua;
}
