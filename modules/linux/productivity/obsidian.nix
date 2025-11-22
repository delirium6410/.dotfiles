{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.productivity.obsidian;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.productivity.obsidian = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    modules.unfreePackages = [ "obsidian" ];
    
    home-manager.users.${username} = {
      home.packages = with pkgs; [ obsidian ];
    };
  };
}