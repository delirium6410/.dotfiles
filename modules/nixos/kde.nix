{ config, pkgs, lib, ... }:
{
  options = {
    machine.kde.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.kde.enable {
    machine.nemo.enable = true;
    machine.sddm.enable = true;

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

    environment.systemPackages = with pkgs; [
      kdePackages.kcalc
      kdePackages.plasma-pa
      eog
      clapper
    ];
    
    environment.sessionVariables = {
      KWIN_DRM_NO_AMS = "1";
    };
  };
}
