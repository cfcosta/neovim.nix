{
  inputs,
  lib,
  pkgs,
  stdenv,
  symlinkJoin,
  ...
}:
let
  inherit (builtins) readFile isPath;
  inherit (stdenv) mkDerivation;

  mkPlugin' =
    name:
    mkPlugin {
      inherit name;
      src = inputs.${name};
      module = null;
      config = "";
    };

  simplePlugins = [
    (mkPlugin' "aiken-neovim")
    (mkPlugin' "colorful-menu")
    (mkPlugin' "comment")
    (mkPlugin' "dressing")
    (mkPlugin' "friendly-snippets")
    (mkPlugin' "lspkind")
    (mkPlugin' "nio")
    (mkPlugin' "nvim-treesitter-endwise")
    (mkPlugin' "nvim-treesitter-just")
    (mkPlugin' "plenary")
    (mkPlugin' "which-key")
  ];

  mkPlugin =
    args@{
      inputs ? [ ],
      name,
      src,
      config ? "",
      depends ? [ ],
      ...
    }:
    let
      plugin = mkDerivation {
        inherit src;
        name = "nightvim-${name}";
        version = src.shortRev or "dev-nightvim";

        dontBuild = true;
        installPhase = ''
          mkdir -p $out/share/nightvim/pack/nightvim/opt/${name}
          cp -r . $out/share/nightvim/pack/nightvim/opt/${name}
        '';

        passthru.spec = {
          inherit
            name
            src
            inputs
            depends
            ;

          config = if isPath config then readFile config else config;
        };
      };
    in
    symlinkJoin {
      name = "nightvim-${args.name}-with-tools";
      paths = [ plugin ] ++ inputs;
      inherit (plugin) passthru;
    };

  importPlugin =
    dir:
    import dir {
      inherit
        pkgs
        inputs
        mkPlugin
        lib
        ;
    };
in
symlinkJoin rec {
  name = "nightvim-plugins";

  paths =
    let
      inherit (builtins) readDir;

      dir = ./.;
      entries = readDir dir;

      importPluginPath =
        name:
        let
          path = dir + "/${name}";
          type = (readDir dir).${name};
        in
        if type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix" then
          importPlugin (dir + "/${name}")
        else if type == "directory" then
          importPlugin path
        else
          null;

      # Filter out non-plugin entries and import all valid plugins
      plugins = lib.filter (x: x != null) (map importPluginPath (builtins.attrNames entries));
    in
    plugins ++ simplePlugins;

  passthru.specs = map (p: p.spec) paths;
}
