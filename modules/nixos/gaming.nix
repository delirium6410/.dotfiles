{ config, pkgs, lib, ... }:
{
  options = {
    machine.gaming.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.gaming.enable {
    machine = {
      gamemode.enable = true;
      gamescope.enable = true;

      retroarch.enable = true;
      steam.enable = true;
      
      wine.enable = true;
    };

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