{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.media.clapper;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.media.clapper = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [ clapper ];

      xdg.mimeApps.defaultApplications = {
        "video/mp4" = "clapper.desktop";
        "video/x-matroska" = "clapper.desktop";
        "video/webm" = "clapper.desktop";
        "video/mpeg" = "clapper.desktop";
        "video/x-msvideo" = "clapper.desktop";
        "audio/mpeg" = "clapper.desktop";
        "audio/mp4" = "clapper.desktop";
        "audio/flac" = "clapper.desktop";
        "audio/ogg" = "clapper.desktop";
        "audio/x-wav" = "clapper.desktop";
      };
    };
  };
}