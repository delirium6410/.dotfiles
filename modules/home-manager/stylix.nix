{ config, lib, pkgs, ... }:
{
  options.machine.stylix = {
    enable = lib.mkEnableOption "";
  };
  
  config = lib.mkIf config.machine.stylix.enable {
    stylix = {   
      targets = {          
        firefox = {
          enable = true;
          profileNames = [ "default" ];
          colorTheme.enable = true;
        };
        gtk.enable = true;
        qt.enable = true;
      };
      
      icons = {
        enable = true;
        package = pkgs.colloid-icon-theme; # whitesur, papirus, reversal, colloid
        dark = "Colloid-Dark"; # WhiteSur-dark, Papirus, Reversal, Colloid-Dark
        light = "Colloid-Light"; # WhiteSur-light, Papirus, Reversal, Colloid-Light
      };
    };
  };
}
