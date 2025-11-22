{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop.swww;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.desktop.swww = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = { config, ... }: {
      xdg.configFile."waypaper" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/waypaper";
        recursive = true;
      };
      
      home.packages = with pkgs; [ 
        swww
        waypaper
      ];
    };
  };
}