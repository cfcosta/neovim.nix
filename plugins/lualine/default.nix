{
  deps,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "lualine";
  src = deps.lualine;

  depends = [
    "catppuccin"
    "nvim-web-devicons"
  ];

  config = readFile ./configuration.lua;
}
