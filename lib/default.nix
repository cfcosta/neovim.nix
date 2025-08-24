{
  callPackage,
  inputs,
  neovim-unwrapped,
  stdenv,
  makeWrapper,
  writeText,
  lib,
  ...
}:
let
  inherit (builtins)
    isAttrs
    isList
    isString
    readFile
    ;
  inherit (stdenv) mkDerivation;

  plugins = callPackage ../plugins { inherit inputs; };

  toLua =
    value:
    if isAttrs value then
      "{ ${lib.concatStringsSep ", " (lib.mapAttrsToList (k: v: "${toLua k} = ${toLua v}") value)} }"
    else if isList value then
      "{ ${lib.concatStringsSep ", " (map toLua value)} }"
    else if isString value then
      "[[${value}]]"
    else
      toString value;

  mapSpec = p: ''
    __nv.setup_plugin(
      ${toLua p.name},
      ${toLua p.depends},
      function()
        ${p.config}
      end
    )'';

  initFile = ''
    vim.opt.packpath:append(${toLua "${plugins}/share/nightvim"})

    local __nv = (function()
      ${readFile ./lua/init.lua}
    end)()

    if vim.env.PROF then
      vim.cmd("packadd! snacks")

      require("snacks.profiler").startup({
        startup = { event = "VimEnter" },
      })
    end

    ${lib.concatStringsSep "\n" (map mapSpec plugins.specs)}

    __nv.finish()
  '';
in
mkDerivation {
  inherit (neovim-unwrapped) meta lua;

  name = "nightvim";
  src = neovim-unwrapped;

  nativeBuildInputs = [ makeWrapper ];

  dontBuild = true;

  installPhase = ''
    mkdir $out
    cp -rf * $out

    wrapProgram $out/bin/nvim \
      --suffix PATH : ${plugins}/bin \
      --set VIMRUNTIME ${neovim-unwrapped}/share/nvim/runtime \
      --set NVIM_APPNAME nightvim \
      --set NIGHTVIM_ROOT ${plugins}/share/nightvim \
      --add-flags "-u ${writeText "init.lua" initFile}"
  '';

  passthru = { inherit plugins; };
}
