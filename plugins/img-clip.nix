{ inputs, mkPlugin, ... }:
mkPlugin {
  name = "img-clip";
  src = inputs.img-clip;
  config = ''
    require("img-clip").setup {}
  '';
}
