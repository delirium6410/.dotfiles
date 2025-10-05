{ config, pkgs, lib, ... }:
{
  options = {
    machine.kde.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.kde.enable {
    machine.sddm.enable = true;
    machine.dolphin.enable = true;

    services.desktopManager.plasma6.enable = true;
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      elisa
      kate
      okular
      gwenview
      kdeconnect-kde
      kwrited
      konsole
      khelpcenter
    ];

    environment.systemPackages = with pkgs;[
      kdePackages.kcalc
      kdePackages.kio-admin
      kdePackages.kio-extras
      kdePackages.kio-fuse
      protonvpn-gui
    ];
    
    environment.sessionVariables = {
      KWIN_DRM_NO_AMS = "1";
    };
  };
}
