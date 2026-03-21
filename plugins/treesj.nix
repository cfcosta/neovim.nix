{ inputs, mkPlugin, ... }:
mkPlugin {
  name = "treesj";
  src = inputs.treesj;

  lazy = {
    cmd = [
      "TSJToggle"
      "TSJSplit"
      "TSJJoin"
    ];
    keys = [
      {
        mode = "n";
        lhs = "<leader>m";
        desc = "Split or Join code block with autodetect";
      }
      {
        mode = "n";
        lhs = "<leader>s";
        desc = "Split code block";
      }
      {
        mode = "n";
        lhs = "<leader>j";
        desc = "Join code block";
      }
    ];
  };

  config = ''
    require("treesj").setup {}
  '';
}
