{ inputs, mkPlugin, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "toggleterm-nvim";
  src = inputs.toggleterm-nvim;

  lazy = {
    keys = [
      {
        mode = "n";
        lhs = "<leader>]";
        desc = "ToggleTerm: Send current line to terminal";
      }
      {
        mode = "n";
        lhs = "<leader>oF";
        desc = "ToggleTerm: Open terminal in new tab";
      }
      {
        mode = "n";
        lhs = "<leader>oT";
        desc = "ToggleTerm: Open vertical terminal";
      }
      {
        mode = "n";
        lhs = "<leader>of";
        desc = "ToggleTerm: Open floating terminal";
      }
      {
        mode = "n";
        lhs = "<leader>ot";
        desc = "ToggleTerm: Open horizontal terminal";
      }
    ];
  };

  config = readFile ./configuration.lua;
}
