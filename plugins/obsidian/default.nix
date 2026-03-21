{ inputs, mkPlugin, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "obsidian-nvim";
  src = inputs.obsidian-nvim;

  depends = [
    "plenary"
    "telescope"
  ];

  lazy = {
    ft = [ "markdown" ];

    keys = [
      {
        mode = "n";
        lhs = "<leader>n/";
        desc = "Obsidian: Search notes";
      }
      {
        mode = "n";
        lhs = "<leader>nT";
        desc = "Obsidian: Open tomorrow's note";
      }
      {
        mode = "n";
        lhs = "<leader>nd";
        desc = "Obsidian: Find daily notes";
      }
      {
        mode = "n";
        lhs = "<leader>nt";
        desc = "Obsidian: Open today's note";
      }
      {
        mode = "n";
        lhs = "<leader>ny";
        desc = "Obsidian: Open yesterday's note";
      }
      {
        mode = "n";
        lhs = "<leader>ns";
        desc = "Obsidian: Quick switch note";
      }
      {
        mode = "n";
        lhs = "<leader>nn";
        desc = "Obsidian: search on currently week notes";
      }
      {
        mode = "n";
        lhs = "<leader>nN";
        desc = "Obsidian: search on previous week notes";
      }
    ];
  };

  config = readFile ./configuration.lua;
}
