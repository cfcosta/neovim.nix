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
  name = "render-markdown";
  src = inputs.render-markdown;

  depends = [ "nvim-web-devicons" ];

  inputs = with pkgs; [
    python312Packages.pylatexenc
  ];

  config = readFile ./configuration.lua;
}
