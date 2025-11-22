{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.security.hardening;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.security.hardening = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    security = {
      sudo-rs.enable = true;
      protectKernelImage = false;
      lockKernelModules = false;
      forcePageTableIsolation = true;
      polkit.enable = true;
      rtkit.enable = true;
      apparmor = {
        enable = true;
        killUnconfinedConfinables = true;
        packages = [ pkgs.apparmor-profiles ];
      };
    };

    fileSystems = let
      defaults = ["nodev" "nosuid" "noexec"];
    in {
      "/boot".options = defaults;
    };

    boot = {
      kernelParams = [
        "slab_nomerge"
        "init_on_alloc=1" 
        "init_on_free=1"
        "page_alloc.shuffle=1"
      ];

      kernel.sysctl = {
        # Network security 
        "net.ipv4.conf.all.rp_filter" = 1;
        "net.ipv4.conf.default.rp_filter" = 1;
        "net.ipv4.conf.all.accept_source_route" = 0;
        "net.ipv4.conf.default.accept_source_route" = 0;
        "net.ipv4.icmp_echo_ignore_broadcasts" = 1;
        "net.ipv4.conf.all.send_redirects" = 0;
        "net.ipv4.conf.default.send_redirects" = 0;
        "net.ipv4.conf.all.accept_redirects" = 0;
        "net.ipv4.conf.default.accept_redirects" = 0;
        
        # Kernel hardening 
        "kernel.dmesg_restrict" = 1;
        "kernel.kptr_restrict" = 2;
        "kernel.unprivileged_bpf_disabled" = 1;
        
        # Filesystem hardening
        "fs.protected_hardlinks" = 1;
        "fs.protected_symlinks" = 1;
        "fs.protected_fifos" = 2;
        "fs.protected_regular" = 2;
      };

      blacklistedKernelModules = [
        # Rare network protocols
        "ax25" "netrom" "rose"

        # Uncommon filesystems
        "cramfs" "freevxfs" "jffs2" "hfs" "hfsplus"
        "udf"
      ];
    };
  };
}