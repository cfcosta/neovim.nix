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

  depends = [ "blink-cmp" ];

  inputs = with pkgs; [
    aiken
    bash-language-server
    buf
    clang-tools
    docker-compose-language-service
    dockerfile-language-server
    gopls
    harper
    jq-lsp
    lua-language-server
    luau
    nixd
    postgres-language-server
    ruff
    taplo
    ty
  ];

  config = readFile ./configuration.lua;

  src = inputs.lspconfig;
}
