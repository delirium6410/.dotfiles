{ config, lib, pkgs, ... }:
{
  options = {
    machine.rofi.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.rofi.enable {
    #stylix.targets.rofi.enable = false;
    programs.rofi = {
      enable = true;
      package = pkgs.rofi;      
      terminal = "ghostty";
    };

    services.cliphist = {
      enable = true;
    };
    
    home.packages = with pkgs; [
      wl-clipboard-rs
    ];

    wayland.windowManager.hyprland.settings = lib.mkIf config.machine.hyprland.enable {
      bind = [ 
        "$mod, F, exec, pkill rofi || rofi -show drun"
        "$mod, V, exec, pkill rofi || cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy"        
      ];
      exec-once = "wl-paste --type text --watch cliphist store";
    };
  };
}