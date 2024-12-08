{
  inputs,
  mkPlugin,
  ...
}:
mkPlugin {
  name = "notify";
  src = inputs.nvim-notify;

  config = builtins.readFile ./configuration.lua;
}
