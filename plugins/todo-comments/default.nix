{ inputs, mkPlugin, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "todo-comments";
  src = inputs.todo-comments;

  depends = [
    "plenary"
    "telescope"
    "trouble"
  ];

  config = readFile ./configuration.lua;
}
