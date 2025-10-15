{ config, pkgs, lib, ... }:
{
  options = {
    machine.gaming.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.gaming.enable {
    machine = {
      steam.enable = true;
      wine.enable = true;
    };
    
    programs.gamescope = {
      enable = true;
      args = [
        "-W 1920"
        "-H 1080"
        "--force-grab-cursor"
        "--rt"
        "-f"
      ];
    };

    users.users.admin.extraGroups = [ "gamemode" ];
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
    
    # https://codeberg.org/fabiscafe/game-devices-udev
    services = {
      libinput.enable = true;
      udev.packages = with pkgs; [ game-devices-udev-rules ];
    };

    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
    
    # https://github.com/fufexan/nix-gaming
    services.pipewire.lowLatency = {
      enable = true;
      quantum = 64;
      rate = 48000;
    };
    
    # https://wiki.archlinux.org/title/Gaming#Improving_performance
    boot.kernelParams = [
      "tsc=reliable"
      "clocksource=tsc"
    ];
    
    boot.kernel.sysctl = {
      "vm.min_free_kbytes" = 2097152; 
      "vm.watermark_scale_factor" = 500;
      "vm.compaction_proactiveness" = 0;
      "vm.watermark_boost_factor" = 1;
      "vm.page_lock_unfairness" = 1;
      "vm.zone_reclaim_mode" = 0;
    };
  };
}