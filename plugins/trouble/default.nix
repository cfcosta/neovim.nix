{ mkPlugin, inputs, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "trouble";
  src = inputs.trouble;

  depends = [ "nvim-web-devicons" ];

  lazy = {
    keys = [
      {
        mode = "n";
        lhs = "<leader>xx";
        desc = "Trouble: Toggle diagnostics";
      }
      {
        mode = "n";
        lhs = "<leader>xX";
        desc = "Trouble: Toggle buffer diagnostics";
      }
      {
        mode = "n";
        lhs = "<leader>cs";
        desc = "Trouble: Toggle symbols";
      }
      {
        mode = "n";
        lhs = "<leader>cl";
        desc = "Trouble: Toggle LSP references";
      }
      {
        mode = "n";
        lhs = "<leader>xL";
        desc = "Trouble: Toggle location list";
      }
      {
        mode = "n";
        lhs = "<leader>xQ";
        desc = "Trouble: Toggle quickfix list";
      }
    ];
  };

  config = readFile ./configuration.lua;
}
