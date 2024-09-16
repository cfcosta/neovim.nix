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
  name = "none-ls";

  depends = [
    "plenary"
    "nvim-lspconfig"
  ];

  inputs = with pkgs; [
    actionlint
    clang-tools
    cmake-format
    deadnix
    jq
    luajitPackages.luacheck
    nixfmt-rfc-style
    postgres-lsp
    python3Packages.regex
    ruff
    ruff-lsp
    shellcheck
    shfmt
    statix
  ];

  config = readFile ./configuration.lua;

  src = deps.none-ls;
}
