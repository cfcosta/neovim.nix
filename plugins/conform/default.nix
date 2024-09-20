{
  deps,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "conform-nvim";
  src = deps.conform-nvim;

  depends = [
    "nvim-lspconfig"
  ];

  config = readFile ./configuration.lua;
}
