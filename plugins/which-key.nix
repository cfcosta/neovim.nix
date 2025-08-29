{ inputs, mkPlugin, ... }:
mkPlugin {
  name = "which-key";
  src = inputs.which-key;
  config = ''
    require("which-key").setup({
      preset = "helix",
    })
  '';
}
