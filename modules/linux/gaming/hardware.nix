{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.gaming.hardware;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.gaming.hardware = {
    enable = mkEnableOption "";
    enableTabletDriver = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    services = {
      libinput.enable = true;
      udev.packages = with pkgs; [ game-devices-udev-rules ];
    };

    hardware.opentabletdriver = mkIf cfg.enableTabletDriver {
      enable = true;
      daemon.enable = true;
    };
  };
}