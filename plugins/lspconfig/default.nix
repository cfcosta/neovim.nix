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
    buf-language-server
    clang-tools
    cmake-format
    gopls
    jq
    lua-language-server
    luajitPackages.luacheck
    nixd
    nixfmt-rfc-style
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.vscode-langservers-extracted
    postgres-lsp
    pyright
    ruff
    ruff-lsp
    shellcheck
    shfmt
  ];

  config = readFile ./configuration.lua;

  src = inputs.lspconfig;
}
