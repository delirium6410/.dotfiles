{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.media.mpv;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.media.mpv = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.mpv.enable = true;
    };
  };
}