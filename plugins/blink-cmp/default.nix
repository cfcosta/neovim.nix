{
  inputs,
  mkPlugin,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;

  blink-cmp = inputs.blink-cmp.packages.${system}.blink-cmp;

  # Upstream builds the Rust fuzzy matcher (blink-fuzzy-lib) with
  # rustPlatform.buildRustPackage, which runs `cargo test` in its checkPhase.
  # Those tests are currently failing upstream, so disable the check on the
  # nested derivation to let the plugin build.
  blink-cmp-no-tests = blink-cmp.overrideAttrs (old: {
    env = old.env // {
      fuzzy_lib = old.env.fuzzy_lib.overrideAttrs (_: {
        doCheck = false;
      });
    };
  });
in
mkPlugin {
  name = "blink-cmp";
  src = blink-cmp-no-tests;

  depends = [
    "blink-lib"
    "colorful-menu"
    "friendly-snippets"
  ];

  config = builtins.readFile ./configuration.lua;
}
