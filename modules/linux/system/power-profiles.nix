{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.system.ppd;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.system.ppd = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    services.power-profiles-daemon.enable = true;
  };
}