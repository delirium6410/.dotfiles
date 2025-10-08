{ config, pkgs, lib, ... }:
{
  options = {
    machine.gamemode.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.gamemode.enable {
    programs.gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 10;
          ioprio = 0;
          inhibit_screensaver = 1;
        };
        gpu = lib.mkMerge [
          {
            apply_gpu_optimisations = "accept-responsibility";
            gpu_device = 0;
          }
          (lib.mkIf config.machine.gpu_amd.enable {
            amd_performance_level = "high";
          })
        ];
        cpu = {
          park_cores = "no";
          pin_cores = "no";
        };
      };
    };
    users.users.admin.extraGroups = [ "gamemode" ];
  };
}