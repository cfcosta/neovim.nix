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
  name = "lspconfig";

  inputs = with pkgs; [
    aiken
    bash-language-server
    buf
    clang-tools
    docker-compose-language-service
    dockerfile-language-server-nodejs
    gopls
    jq-lsp
    lua-language-server
    luau
    nixd
    postgres-lsp
    ruff
    taplo-lsp
  ];

  config = readFile ./configuration.lua;

  src = inputs.lspconfig;
}
