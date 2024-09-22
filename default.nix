{
  callPackage,
  inputs,
  neovim-unwrapped,
  stdenv,
  makeWrapper,
  writeText,
  ...
}:
let
  inherit (builtins)
    concatStringsSep
    map
    readFile
    ;
  inherit (stdenv) mkDerivation;

  plugins = callPackage ./plugins { inherit inputs; };

  quoteString = d: ''"${d}"'';
  listToLua = list: "{${concatStringsSep " , " (map quoteString list)}}";

  mapSpec = p: ''
    __nv.setup_plugin(
      "${p.name}",
      ${listToLua p.depends},
      function()
        ${p.config}
      end
    )'';

  initFile = ''
    vim.opt.packpath:append("${plugins}/share/nightvim")

    local __nv = (function()
      ${readFile ./lua/init.lua}
    end)()

    ${concatStringsSep "\n" (map mapSpec plugins.specs)}

    __nv.finish()
  '';
in
mkDerivation {
  inherit (neovim-unwrapped) meta lua;

  name = "nightvim";
  src = neovim-unwrapped;

  nativeBuildInputs = [
    makeWrapper
  ];

  dontBuild = true;
  installPhase = ''
    mkdir $out
    cp -rf * $out

    wrapProgram $out/bin/nvim \
      --suffix PATH : ${plugins}/bin \
      --set NVIM_APPNAME nightvim \
      --add-flags "-u ${writeText "init.lua" initFile}"
  '';

  passthru = {
    inherit plugins;
  };
}
