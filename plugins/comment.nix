{
  inputs,
  mkPlugin,
  ...
}:
mkPlugin {
  name = "comment";
  src = inputs.comment;
  config = ''
    require("comment").setup {}
  '';
}
