{
  mkPlugin,
  inputs,
  pkgs,
  ...
}:
let
  inherit (builtins) readFile;
  inherit (pkgs.nightvim) buildRustPackage;

  src = buildRustPackage {
    name = "nightvim-avante-lib";
    src = inputs.avante-nvim;

    doCheck = false;

    buildFeatures = [ "luajit" ];

    buildInputs = with pkgs; [ openssl.dev ];

    nativeBuildInputs = with pkgs; [
      openssl
      pkg-config
      perl
    ];

    cargoLock = {
      lockFile = "${inputs.avante-nvim}/Cargo.lock";
      outputHashes."hf-hub-0.4.1" = "sha256-8IkbFytOolQGyEhGzjqVCguSLYaN6E8BUgekf1auZUk=";
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
    "img-clip"
    "lspconfig"
    "nui"
    "nvim-web-devicons"
    "plenary"
  ];

  config = readFile ./configuration.lua;
}
