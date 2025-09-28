{ config, lib, pkgs, ... }:
{
  options = {
    machine.hyprland.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
      ];
    };
    
    programs.xfconf.enable = true;
    services = {
      gvfs.enable = true;
      tumbler.enable = true;
    };

    services.greetd = {
      enable = true;
      package = pkgs.greetd.tuigreet;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd Hyprland";
        };
      };
    };
  };
}
