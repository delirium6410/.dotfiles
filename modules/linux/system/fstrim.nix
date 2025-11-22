{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.system.fstrim;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.system.fstrim = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    services.fstrim.enable = true;
  };
}