{ config, pkgs, lib, ... }:
{
  options = {
    machine = {
      sddm.enable = lib.mkEnableOption "";
      hidpi.enable = lib.mkEnableOption "";
    };
  };

  config = lib.mkIf config.machine.sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = lib.mkIf config.machine.hidpi.enable true;
      autoNumlock = true;
    };

    security.pam.services.sddm.kwallet.enable = lib.mkIf config.machine.kde.enable true;
  };
}
