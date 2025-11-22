{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.gaming.kernel;
  inherit (lib) mkEnableOption mkIf mkForce;
in
{
  options.modules.gaming.kernel = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    boot = {
      kernelPackages = mkForce pkgs.linuxPackages_xanmod_latest;

      kernelParams = [
        "tsc=reliable"
        "clocksource=tsc"
        "mitigations=off"
      ];

      kernel.sysctl = {
        # Memory optimizations
        "vm.min_free_kbytes" = 2097152; 
        "vm.watermark_scale_factor" = 500;
        "vm.compaction_proactiveness" = 0;
        "vm.watermark_boost_factor" = 1;
        "vm.page_lock_unfairness" = 1;
        "vm.zone_reclaim_mode" = 0;

        # Network optimizations
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
  };
}