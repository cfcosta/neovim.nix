{
  inputs,
  mkPlugin,
  ...
}:
mkPlugin {
  name = "fix-cursor-hold";
  src = inputs.fix-cursor-hold;
  config = "";
}
