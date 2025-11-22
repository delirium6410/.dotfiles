{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.tools.media-tools;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.tools.media-tools = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [      
        ffmpeg
        imagemagick
        mediainfo
        exiftool
      ];
    };      
  };
}