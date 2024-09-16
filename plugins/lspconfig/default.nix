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
    actionlint
    buf-language-server
    clang-tools
    cmake-format
    deadnix
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
    python3Packages.regex
    ruff
    ruff-lsp
    shellcheck
    shfmt
    statix
  ];

  config = readFile ./configuration.lua;

  src = deps.nvim-lspconfig;
}
