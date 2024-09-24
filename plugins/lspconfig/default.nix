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
    beancount-language-server
    buf-language-server
    cairo-lang
    clang-tools
    docker-compose-language-service
    dockerfile-language-server-nodejs
    gopls
    jq-lsp
    lua-language-server
    nixd
    postgres-lsp
    ruff
    ruff-lsp
    taplo-lsp
  ];

  config = readFile ./configuration.lua;

  src = inputs.lspconfig;
}
