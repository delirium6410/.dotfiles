{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.media.spotify;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.media.spotify = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    modules.unfreePackages = [ "spotify" ];
    
    home-manager.users.${username} = {
      home.packages = with pkgs; [ spotify ];
    };
  };
}