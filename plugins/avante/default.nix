{
  mkPlugin,
  deps,
  pkgs,
  lib,
  ...
}:
let
  inherit (builtins) readFile;
  inherit (pkgs.rustPlatform) buildRustPackage;
  inherit (pkgs.stdenv) isDarwin;
  inherit (lib) optionals;

  src = buildRustPackage {
    name = "avante-lib";
    src = deps.avante-nvim;

    doCheck = false;

    buildFeatures = [ "luajit" ];

    buildInputs =
      with pkgs;
      [ openssl.dev ] ++ optionals isDarwin [ darwin.apple_sdk.frameworks.Security ];

    nativeBuildInputs = with pkgs; [
      openssl
      pkg-config
    ];

    cargoLock = {
      lockFile = "${deps.avante-nvim}/Cargo.lock";
      outputHashes = {
        "mlua-0.10.0-beta.1" = "sha256-ZEZFATVldwj0pmlmi0s5VT0eABA15qKhgjmganrhGBY=";
      };
    };

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
    "nui"
    "nvim-web-devicons"
    "plenary"
  ];

  config = readFile ./configuration.lua;
}
