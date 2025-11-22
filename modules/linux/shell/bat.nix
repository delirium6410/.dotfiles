{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.shell.bat;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.shell.bat = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.bat.enable = true;
      
      home.shellAliases = {
        cat = "bat";
      };
    };
  };
}