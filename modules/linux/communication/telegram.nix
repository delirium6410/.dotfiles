{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.communication.telegram;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.communication.telegram = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [ telegram-desktop ];
    };
  };
}