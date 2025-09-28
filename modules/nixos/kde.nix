{ config, pkgs, lib, ... }:
{
  options = {
    machine.kde.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.kde.enable {
    machine.sddm.enable = true;

    services.desktopManager.plasma6.enable = true;
    services.tumbler.enable = true;
    environment.systemPackages = with pkgs;[
      kdePackages.kdeplasma-addons
      kdePackages.kcalc
      kdePackages.dolphin

      kdePackages.ark
      p7zip
      unrar
    ];
  };
}
