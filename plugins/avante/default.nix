{
  deps,
  mkPlugin,
  pkgs,
  ...
}:
let
  inherit (builtins) readFile;
  inherit (pkgs) symlinkJoin;
  inherit (pkgs.stdenv) isDarwin mkDerivation;

  baseUrl = "https://github.com/yetone/avante.nvim/releases/download/v0.0.2/";
  file =
    if isDarwin then
      "avante_lib-macos-latest-lua51.tar.gz"
    else
      "avante_lib-ubuntu-latest-lua51.tar.gz";
  sha256 = if isDarwin then "sha256:1kn56z2r52fwbjcj143ymd84pn2sdcpflhg5kcljslm57rlp2cnn" else "";

  avante_lib = mkDerivation {
    name = "avante_lib";

    src = fetchTarball {
      url = "${baseUrl}${file}";
      inherit sha256;
    };
    buildPhase = "";

    installPhase = ''
      mkdir -p $out/build
      cp * $out/build
    '';
  };
in
mkPlugin {
  name = "avante.nvim";
  src = symlinkJoin {
    name = "avante-nvim-with-lib";

    paths = [
      avante_lib
      deps.avante-nvim
    ];
  };

  depends = [
    "dressing"
    "nui"
    "nvim-web-devicons"
    "plenary"
    "render-markdown"
  ];

  config = readFile ./configuration.lua;
}
