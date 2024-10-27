{
  mkPlugin,
  inputs,
  pkgs,
  lib,
  ...
}:
let
  inherit (builtins) readFile;
  inherit (pkgs.nightvim) buildRustPackage;
  inherit (pkgs.stdenv) isDarwin;
  inherit (lib) optionals;

  src = buildRustPackage {
    name = "nightvim-avante-lib";
    src = inputs.avante-nvim;

    doCheck = false;

    buildFeatures = [ "luajit" ];

    buildInputs =
      with pkgs;
      [ openssl.dev ] ++ optionals isDarwin [ darwin.apple_sdk.frameworks.Security ];

    nativeBuildInputs = with pkgs; [
      openssl
      pkg-config
    ];

    cargoLock.lockFile = "${inputs.avante-nvim}/Cargo.lock";

    installPhase = ''
      mkdir -p $out/build

      find . -iname "libavante*.*" -print | while read -r file; do
        cp "$file" $out/build/$(basename $file | sed 's/^lib//')
      done

      cargo clean

      cp -rf * $out/
    '';
  };
in
mkPlugin {
  inherit src;

  name = "avante.nvim";

  depends = [
    "dressing"
    "lspconfig"
    "nui"
    "nvim-web-devicons"
    "plenary"
  ];

  config = readFile ./configuration.lua;
}
