{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop.hyprland;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.desktop.hyprland = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    modules.desktop = {
      thunar.enable = true;
      cliphist.enable = true;
      hypridle.enable = true;
      hyprlock.enable = true;
      swaync.enable = true;
      gammastep.enable = true;
      rofi.enable = true;
      screenshot.enable = true;
      swww.enable = true;
      tuigreet.enable = true;
      udiskie.enable = true;
      waybar.enable = true;
      wlogout.enable = true;
    };

    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };
    
    services.gnome.gnome-keyring.enable = true;

    home-manager.users.${username} = { config, lib, osConfig, ... }: {
      xdg.configFile."hypr/modules" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/hypr";
        recursive = true;
      };  

      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false;
        extraConfig = ''
          source = ./modules/autostart.conf
          source = ./modules/general.conf
          source = ./modules/keybinds.conf
          source = ./modules/visuals.conf
          source = ./modules/windowrules.conf
          source = ./modules/${osConfig.networking.hostName}/monitor.conf
        '';

        settings = {
          general = {
            "col.active_border" = lib.mkForce "rgba(${config.lib.stylix.colors.base04}e6) rgba(${config.lib.stylix.colors.base05}e6)";
            "col.inactive_border" = lib.mkForce "rgba(${config.lib.stylix.colors.base03}ff)";
          };

          decoration = {
            shadow = {
              color = lib.mkForce "rgba(${config.lib.stylix.colors.base02}a0)";
            };
          };
        };
      };    

      home.file.".config/hypr/gamemode.sh" = {
        text = ''
          #!/usr/bin/env sh
          HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
          if [ "$HYPRGAMEMODE" = 1 ] ; then
              hyprctl --batch "\
                  keyword animations:enabled 0;\
                  keyword animation borderangle,0; \
                  keyword decoration:shadow:enabled 0;\
                  keyword decoration:blur:enabled 0;\
                  keyword decoration:fullscreen_opacity 1;\
                  keyword general:gaps_in 0;\
                  keyword general:gaps_out 0;\
                  keyword general:border_size 1;\
                  keyword decoration:rounding 0"
              exit
          else
              hyprctl reload
              exit 0
          fi
          exit 1
        '';
        executable = true;
      };
    };
  };
}