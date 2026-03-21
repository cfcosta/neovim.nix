{
  inputs,
  mkPlugin,
  pkgs,
  ...
}:
let
  inherit (builtins) readFile;
  inherit (pkgs.stdenv.hostPlatform) system;
in
mkPlugin {
  name = "fff";
  src = inputs.fff.packages.${system}.fff-nvim;

  lazy.keys = [
    {
      mode = "n";
      lhs = "<leader><leader>";
      desc = "fff: find file in git repo";
    }
    {
      mode = "n";
      lhs = "<leader>ff";
      desc = "fff: find file";
    }
  ];

  config = readFile ./configuration.lua;
}
