{ inputs, mkPlugin, ... }:
mkPlugin {
  name = "tokyonight";
  src = inputs.tokyonight;
  config = ''
    vim.cmd [[colorscheme tokyonight-storm]]
  '';
}
