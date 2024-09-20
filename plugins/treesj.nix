{ deps, mkPlugin, ... }:
mkPlugin {
  name = "treesj";
  src = deps.treesj;
}
