{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.theming.stylix;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  options.modules.theming.stylix = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    modules.theming.colors.enable = true;
    
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
        package = pkgs.rose-pine-hyprcursor;
        name = "rose-pine-hyprcursor";
        size = 26;
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

    home-manager.users.${username} = { pkgs, ... }: {
      home.packages = with pkgs; [ 
        gowall
        nerd-fonts.symbols-only
      ];
      
      stylix = {   
        targets = {         
          firefox = {
            enable = true;
            profileNames = [ "default" ];
            colorTheme.enable = true;
          };
          # hasnt been backported yet sadge, unstable only
          # zen-browser = {
          #   enable = true;
          #   profileNames = [ "default" ];
          # };
          gtk.enable = true;
          qt.enable = true;
        };
        
        icons = {
          enable = true;
          package = pkgs.colloid-icon-theme;
          dark = "Colloid-Dark";
          light = "Colloid-Light";
        };
      };
    };
  };
}