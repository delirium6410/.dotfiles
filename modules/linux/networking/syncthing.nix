{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.networking.syncthing;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.networking.syncthing = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
    };
  };
}