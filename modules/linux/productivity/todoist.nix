{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.productivity.todoist;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.productivity.todoist = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    modules.unfreePackages = [ "todoist-electron" ];
    
    home-manager.users.${username} = {
      home.packages = with pkgs; [ 
        todoist-electron
      ];
    };
  };
}