{ config, pkgs, lib, ... }:
{
  options = {
    machine.sddm.enable = lib.mkEnableOption "";
    machine.sddm.hidpi = lib.mkEnableOption "";
    machine.sddm.autoLogin = lib.mkEnableOption "" // {
      default = false;
    };
  };

  config = lib.mkIf config.machine.sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = lib.mkIf config.machine.sddm.hidpi true;
      autoNumlock = true;
      autoLogin = lib.mkIf config.machine.sddm.autoLogin {
        enable = true;
        user = "admin";
      };
    };

    security.pam.services.sddm = {
      kwallet.enable = lib.mkIf config.machine.kde.enable true;
      enableGnomeKeyring = lib.mkIf config.machine.hyprland.enable true;
    };
  };
}
