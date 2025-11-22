{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.browsers.tor-browser;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.browsers.tor-browser = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [ tor-browser ];
    };
  };
}