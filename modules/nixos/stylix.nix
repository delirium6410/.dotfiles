{ config, lib, pkgs, ... }:
{
  options.machine.stylix = {
    enable = lib.mkEnableOption "";
  };
  
  config = lib.mkIf config.machine.stylix.enable {
    stylix = {
      enable = true;
      autoEnable = true;
      polarity = "dark";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

      fonts = {
        monospace = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Monospace";
        };
        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
      };

      iconTheme = {
        enable = true;
        package = pkgs.whitesur-icon-theme;
        dark = "WhiteSur-dark";
        light = "WhiteSur";
      };
      
      targets = {
        plymouth = {
          enable = true;
          logo = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
          logoAnimated = false;
        };
      };
        
      homeManagerIntegration = {
        autoImport = true;
        followSystem = true;
      };
    };

    environment.systemPackages = with pkgs; [ 
      gowall
    ];
  };
}
