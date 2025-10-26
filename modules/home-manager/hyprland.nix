{ config, lib, pkgs, osConfig, ... }:
{
  options = {
    machine.hyprland.enable = lib.mkEnableOption "";
    machine.hyprland.visuals = lib.mkEnableOption "" // {
      default = true;
    };
  };

  config = lib.mkIf config.machine.hyprland.enable {
    machine.mako.enable = true;
    machine.rofi.enable = true;
    
    xdg.configFile."hypr" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/hypr";
      recursive = true;
    };
    
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      extraConfig = ''
        source = ~/.config/hypr/general.conf
        source = ~/.config/hypr/keybinds.conf
        source = ~/.config/hypr/windowrules.conf
        source = ~/.config/hypr/${osConfig.networking.hostName}/monitor.conf
        ${lib.optionalString config.machine.hyprland.visuals "source = ~/.config/hypr/visuals-enabled.conf"}
        ${lib.optionalString (!config.machine.hyprland.visuals) "source = ~/.config/hypr/visuals-disabled.conf"}
      '';

      settings = {
        general = {
          "col.active_border" = lib.mkForce "rgba(${config.lib.stylix.colors.base02}ff) rgba(${config.lib.stylix.colors.base02}ff)";
          "col.inactive_border" = lib.mkForce "rgba(${config.lib.stylix.colors.base02}ff)";
        };

        decoration = {
          shadow = {
            color = lib.mkForce "rgba(${config.lib.stylix.colors.base02}ff)";
          };
        };
      };
    };    
  };
}