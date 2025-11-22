{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.shell.navi;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.shell.navi = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.navi = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}