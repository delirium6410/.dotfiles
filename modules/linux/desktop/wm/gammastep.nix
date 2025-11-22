{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop.gammastep;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.desktop.gammastep = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      services.gammastep = {
        enable = true;
        provider = "manual";
        latitude = 52.5;
        longitude = 13.4;
        temperature = {
          day = 6500;
          night = 3000;
        };
        settings = {
          general = {
            fade = 1;
            adjustment-method = "wayland";
          };
        };
      };
    };
  };
}