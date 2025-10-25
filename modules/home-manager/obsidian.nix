{ config, pkgs, lib, ... }:
{
  options = {
    machine.obsidian.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.obsidian.enable {
    home.packages = with pkgs; [ obsidian ];

    wayland.windowManager.hyprland.settings = lib.mkIf config.machine.hyprland.enable {
      bind = [
        "$mod, O, exec, obsidian --disable-gpu"
      ];
    };
  };
}
