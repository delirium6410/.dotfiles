{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.media.eog;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.media.eog = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [ eog ];

      xdg.mimeApps.defaultApplications = {
        "image/jpeg" = "org.gnome.eog.desktop";
        "image/png" = "org.gnome.eog.desktop";
        "image/gif" = "org.gnome.eog.desktop";
        "image/webp" = "org.gnome.eog.desktop";
        "image/svg+xml" = "org.gnome.eog.desktop";
      };
    };
  };
}