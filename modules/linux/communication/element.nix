{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.communication.element;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.communication.element = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [ element-desktop ];
    };
  };
}