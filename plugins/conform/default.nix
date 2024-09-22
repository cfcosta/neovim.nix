{
  inputs,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "conform-nvim";
  src = inputs.conform-nvim;

  depends = [
    "lspconfig"
  ];

  config = readFile ./configuration.lua;
}
