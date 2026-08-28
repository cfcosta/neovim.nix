{
  inputs,
  mkPlugin,
  pkgs,
  ...
}:
let
  inherit (builtins) readFile;

  # The diagnostics/completion backend shells out to a bundled `beancheck.py`,
  # so it needs a Python that can import `beancount`.
  python = pkgs.python3.withPackages (ps: with ps; [ beancount ]);
in
mkPlugin {
  name = "beancount";
  src = inputs.beancount-nvim;

  depends = [ "blink-cmp" ];

  lazy.ft = [ "beancount" ];

  config = ''
    local python_path = "${python}/bin/python3"

    ${readFile ./configuration.lua}
  '';
}
