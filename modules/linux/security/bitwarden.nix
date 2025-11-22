{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.security.bitwarden;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.security.bitwarden = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [ bitwarden ];
    };
  };
}