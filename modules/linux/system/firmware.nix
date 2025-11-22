{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.system.firmware;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.system.firmware = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    services.fwupd.enable = true;
    hardware.enableRedistributableFirmware = true;
    services.hardware.bolt.enable = true;
  };
}