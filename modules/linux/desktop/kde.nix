{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.modules.desktop.kde;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.desktop.kde = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    services.desktopManager.plasma6.enable = true;
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      elisa
      kate
      okular
      gwenview
      kdeconnect-kde
      kwrited
      konsole
      khelpcenter
    ];

    environment.systemPackages = with pkgs; [
      # compatability since sometimes icons are randomly missing
      kdePackages.breeze-icons
      adwaita-icon-theme
    ];
    
    environment.sessionVariables = {
      KWIN_DRM_NO_AMS = "1";
    };

    home-manager.users.${username} = {
      imports = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];
      
      programs.plasma = {
        enable = true;
        
        shortcuts = {
          "kwin"."Window Close" = "Meta+Q";
        };
      };
    };
  };
}