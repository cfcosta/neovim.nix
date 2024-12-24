{
  inputs,
  mkPlugin,
  pkgs,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "conform-nvim";
  src = inputs.conform-nvim;

  depends = [ "lspconfig" ];

  inputs = with pkgs; [
    beancount
    cmake-format
    gofumpt
    jq
    nixfmt-rfc-style
    ruff
    shellcheck
    shfmt
    stylua
    taplo
    yq
  ];

  config = readFile ./configuration.lua;
}
