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
        fwupd.enable = true;
        home-manager.enable = true;
        i18n.enable = true;
        nix-ld.enable = true;
        nix.enable = true;
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
      machine = {
        bluetooth.enable = true;
        bolt.enable = true;
        networkmanager.enable = true;
        pipewire.enable = true;
      };
      boot = {
        kernelParams = ["mem_sleep_default=deep"];
        initrd.systemd.enable = true;
      };

      #services.logind.settings.Login = let
      #  suspendBehavior = "suspend-then-hibernate";
      #in {
      #  HandleLidSwitch = suspendBehavior;
      #  HandlePowerKey = suspendBehavior;
      #  HandlePowerKeyLongPress = "poweroff";
      #};

      services.throttled.enable = true;
      systemd.sleep.extraConfig = ''
        HibernateDelaySec=30m
        SuspendState=mem
      '';
    })
  ];
}
