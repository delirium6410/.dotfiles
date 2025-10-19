{ config, lib, pkgs, ... }:
{
  options = {
    machine.hyprland.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.hyprland.enable {
    machine.dolphin.enable = true;
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
    };

    environment.sessionVariables = {
      XDG_CURRENT_DESKTOP = "wayland";
      XDG_SESSION_DESKTOP = "wayland";
      XDG_SESSION_TYPE = "wayland";
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      GDK_SCALE = "1";
      GDK_DPI_SCALE = "1";
    };
  };
}
