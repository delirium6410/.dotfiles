{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.desktop.hyprpolkitagent;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.desktop.hyprpolkitagent = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      services.hyprpolkitagent = {
        enable = true;
      };
    };
  };
}