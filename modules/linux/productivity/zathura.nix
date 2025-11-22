{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.productivity.zathura;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.productivity.zathura = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.zathura = {
        enable = true;
        mappings = {

        };
      };

      xdg.mimeApps.defaultApplications = {
        "application/pdf" = "org.pwmt.zathura.desktop";
      };
    };
  };
}