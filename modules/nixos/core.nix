{ config, lib, pkgs, ... }:
{
  options.machine.core = {
    enable = lib.mkEnableOption "";
    laptop = lib.mkEnableOption "";
  };

  config = lib.mkMerge [
    (lib.mkIf config.machine.core.enable {
      machine = {
        # add pam, yubikey, secrets, ssh, lanzaboote, persistence, disko, (apparmor?)
        avahi.enable = true;
        bluetooth.enable = true;
        bolt.enable = true;
        fwupd.enable = true;
        home-manager.enable = true;
        i18n.enable = true;
        networkmanager.enable = true;
        nix-ld.enable = true;
        nix.enable = true;
        pipewire.enable = true;
        plymouth.enable = true;
        sudo-rs.enable = true;
        systemd-boot.enable = true;
        tailscale.enable = true;
      };

      services.fstrim.enable = true;

      users.mutableUsers = false;
      users.users.root = {
        hashedPassword = "!";
      };
    })
    (lib.mkIf config.machine.core.laptop {
      services.throttled.enable = true;

      boot = {
        kernelParams = ["mem_sleep_default=deep"];
        initrd.systemd.enable = true;
      };

      systemd.sleep.extraConfig = ''
        HibernateDelaySec=30m
        SuspendState=mem
      '';
    })
  ];
}
