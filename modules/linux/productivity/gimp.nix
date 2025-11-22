{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.productivity.gimp;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.productivity.gimp = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [ gimp ];
    };
  };
}