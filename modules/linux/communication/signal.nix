{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.communication.signal;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.communication.signal = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [ signal-desktop ];
    };
  };
}