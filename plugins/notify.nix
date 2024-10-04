{
  inputs,
  mkPlugin,
  ...
}:
mkPlugin {
  name = "notify";
  src = inputs.nvim-notify;

  config = ''
    vim.notify = require("notify")
  '';
}
