{ config, lib, pkgs, ... }:
{
  options = {
    machine.hyprland.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.hyprland.enable {
    home.packages = with pkgs; [
      mako
    ];

    programs.rofi = {
      enable = true;
      location = "center";
      terminal = "ghostty";
      extraConfig = {
        modi = "drun,run";
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        general = {
          "col.active_border" = lib.mkForce "rgba(${config.lib.stylix.colors.base02}ff) rgba(${config.lib.stylix.colors.base02}ff)";
          "col.inactive_border" = lib.mkForce "rgba(${config.lib.stylix.colors.base02}ff)";
        };
      };
    };
    
    home.sessionVariables = {
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";

      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      _JAVA_AWT_WM_NONREPARENTING = "1";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland,x11";

      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };
  };
}
