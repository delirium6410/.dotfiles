{ config, pkgs, lib, ... }:
{
  options = {
    machine.gnome.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.gnome.enable {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    
    environment.gnome.excludePackages = with pkgs.kdePackages; [
      gnome-tour 
      gnome-user-docs
    ];

    programs.dconf.enable = true;
  };
}
