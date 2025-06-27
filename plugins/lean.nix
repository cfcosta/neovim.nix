{
  inputs,
  mkPlugin,
  pkgs,
  ...
}:
mkPlugin {
  name = "lean";
  src = inputs.lean;

  inputs = with pkgs; [
    lean4
  ];

  depends = [
    "lspconfig"
    "plenary"
  ];

  config = ''
    require('lean').setup{
      abbreviations = { builtin = true },
      mappings = true,
    }
  '';
}
