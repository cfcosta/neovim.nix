{
  inputs,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "render-markdown";
  src = inputs.render-markdown;

  depends = [
    "nvim-web-devicons"
  ];

  config = readFile ./configuration.lua;
}
