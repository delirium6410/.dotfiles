{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.system.xdg;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.system.xdg = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = { config, lib, pkgs, ... }: {
      xdg = {
        userDirs = {
          enable = true;
          createDirectories = true;
          desktop = "${config.home.homeDirectory}/Desktop";
          documents = "${config.home.homeDirectory}/Documents";
          download = "${config.home.homeDirectory}/Downloads";
          music = "${config.home.homeDirectory}/Music";
          pictures = "${config.home.homeDirectory}/Pictures";
          publicShare = "${config.home.homeDirectory}/Public";
          templates = "${config.home.homeDirectory}/Templates";
          videos = "${config.home.homeDirectory}/Videos";
          # could be used for directories that programs like wallpapers need in a modular fashion
          extraConfig = {
            XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
            XDG_WALLPAPERS_DIR = "${config.home.homeDirectory}/Pictures/Wallpapers";
          };
        };
      };
      home.packages = with pkgs; [ 
        xdg-utils
        xdg-ninja
      ];
    };
  };
}