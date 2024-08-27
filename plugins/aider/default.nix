{ mkPlugin, deps, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "aider.nvim";
  src = deps.aider;

  depends =
    [
    ];

  config = readFile ./configuration.lua;
}
