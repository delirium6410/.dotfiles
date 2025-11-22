{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.gaming.gamemode;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.gaming.gamemode = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    users.users.${username}.extraGroups = [ "gamemode" ];

    programs = {
      gamemode = {
        enable = true;
        settings = {
          general = {
            renice = -10;
            ioprio = 0;
            inhibit_screensaver = 1;
          };
          gpu = {
            apply_gpu_optimisations = "accept-responsibility";
            gpu_device = 0;
            amd_performance_level = "high";
          };
          cpu = {
            park_cores = "no";
            pin_cores = "no";
          };
        };
      };

      gamescope = {
        enable = true;
        capSysNice = true;
      };
    };
  };
}