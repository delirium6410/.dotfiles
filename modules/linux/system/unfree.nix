{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkOption types;
in
{
  options.modules.unfreePackages = mkOption {
    type = types.listOf types.str;
    default = [];
    description = "this merges all unfree packages together";
  };
}