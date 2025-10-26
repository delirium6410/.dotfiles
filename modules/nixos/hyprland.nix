{ config, lib, pkgs, ... }:
{
  options = {
    machine.hyprland.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.hyprland.enable {
    machine.thunar.enable = true;
    machine.sddm.enable = true;

    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      config.common.default = "hyprland;gtk";
    };

    environment.systemPackages = with pkgs; [
      eog
      clapper
    ];

    services.gnome.gnome-keyring.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };
  };
}
