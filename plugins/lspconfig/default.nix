{
  deps,
  mkPlugin,
  pkgs,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "nvim-lspconfig";

  inputs = with pkgs; [
    buf-language-server
    gopls
    lua-language-server
    nixd
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.vscode-langservers-extracted
    pyright
    ruff
  ];

  config = readFile ./configuration.lua;

  src = deps.nvim-lspconfig;
}
