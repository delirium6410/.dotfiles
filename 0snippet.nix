{ config, lib, pkgs, ... }:
{
  options = {
    machine.placeholder.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.placeholder.enable {
  };

  options = {
    machine.placeholder = {
      enable = lib.mkEnableOption "";
    };
    machine.placeholder = {
      enable = lib.mkEnableOption "";
    };
  };

  wayland.windowManager.hyprland.settings.bind = lib.mkIf config.machine.hyprland.enable [  ];
  
  config = lib.mkMerge [
    (lib.mkIf config.machine.placeholder.enable {

    })
    (lib.mkIf config.machine.placeholder.enable {

    })
  ];  
}