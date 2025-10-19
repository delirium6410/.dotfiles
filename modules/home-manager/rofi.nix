{ config, lib, pkgs, ... }:
{
  options = {
    machine.rofi.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.rofi.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;      
      terminal = "ghostty";
      
      extraConfig = {
        modes = "drun,run,window";        
        drun-display-format = "{name}";
        window-format = "{w} · {c} · {t}";
        show-icons = true;
        lines = 12; 
        columns = 1; 
        width = 50; 
        matching = "fuzzy";
        case-sensitive = false;
      };
    };
  };
}