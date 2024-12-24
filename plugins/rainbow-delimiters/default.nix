{ inputs, mkPlugin, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "rainbow-delimiters";
  src = inputs.rainbow-delimiters;
  config = readFile ./configuration.lua;
}
