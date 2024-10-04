{
  inputs,
  mkPlugin,
  ...
}:
mkPlugin {
  name = "pomo";
  src = inputs.pomo-nvim;

  depends = [ "notify" ];

  config = ''
    require("pomo").setup({})
  '';
}
