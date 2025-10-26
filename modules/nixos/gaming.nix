{ config, pkgs, lib, ... }:
{
  options = {
    machine.gaming.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.gaming.enable {  
    boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    users.users.admin.extraGroups = [ "gamemode" ];
    programs.gamemode = {
      enable = true;
      settings = {
        general = {
          renice = -10;
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
      udev.packages = with pkgs; [ game-devices-udev-rules ]; # make supported controllers available with user-grade permissions
    };

    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
    
    # https://wiki.archlinux.org/title/Gaming#Improving_performance
    boot.kernelParams = [
      "tsc=reliable"
      "clocksource=tsc"
      "mitigations=off"
    ];
    
    boot.kernel.sysctl = {
      "vm.min_free_kbytes" = 2097152; 
      "vm.watermark_scale_factor" = 500;
      "vm.compaction_proactiveness" = 0;
      "vm.watermark_boost_factor" = 1;
      "vm.page_lock_unfairness" = 1;
      "vm.zone_reclaim_mode" = 0;

      "net.ipv4.tcp_fastopen" = 3;
      "net.ipv4.tcp_low_latency" = 1;
      "net.ipv4.tcp_timestamps" = 1;
      "net.ipv4.tcp_sack" = 1;
      "net.ipv4.tcp_window_scaling" = 1;
      
      "net.core.netdev_max_backlog" = 16384;
      "net.core.rmem_max" = 134217728;
      "net.core.wmem_max" = 134217728;
      "net.ipv4.tcp_rmem" = "4096 87380 67108864";
      "net.ipv4.tcp_wmem" = "4096 87380 67108864";
      
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "cake";
    };
  };
}