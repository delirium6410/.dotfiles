{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.communication.thunderbird;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.communication.thunderbird = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.thunderbird = {
        enable = true;
        profiles = {};
        settings = {
          "privacy.donottrackheader.enabled" = true; 
        };
      };
    };
  };
}