{ config, pkgs, lib, ... }:
{
  options = {
    machine.hardening.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.hardening.enable {
    # https://github.com/sioodmy/dotfiles/blob/main/system/security/default.nix
    # https://docs.arbitrary.ch/security/
    # https://docs.redhat.com/de/documentation/red_hat_enterprise_linux/8/html/security_hardening/index
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
      #"/var/log".options = defaults;
    };

    boot = {
      kernelParams = [
        "slab_nomerge"
        "init_on_alloc=1" 
        "init_on_free=1"
      ];

      blacklistedKernelModules = [
        "ax25"
        "netrom"
        "rose"
        "adfs"
        "affs"
        "bfs"
        "befs"
        "cramfs"
        "efs"
        "erofs"
        "exofs"
        "freevxfs"
        "f2fs"
        "vivid"
        "gfs2"
        "ksmbd"
        "nfsv4"
        "nfsv3"
        "cifs"
        "nfs"
        "jffs2"
        "hfs"
        "hfsplus"
        "squashfs"
        "udf"
        "hpfs"
        "jfs"
        "minix"
        "nilfs2"
        "omfs"
        "qnx4"
        "qnx6"
        "sysv"
      ];
    };
  };
}