{ inputs, mkPlugin, ... }:
mkPlugin {
  name = "treesj";
  src = inputs.treesj;
  config = ''
    require("treesj").setup {}
  '';
}
