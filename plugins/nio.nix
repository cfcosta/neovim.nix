{
  inputs,
  mkPlugin,
  ...
}:
mkPlugin {
  name = "nio";
  src = inputs.nio-nvim;
  config = "";
}
