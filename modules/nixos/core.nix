{ config, lib, pkgs, ... }:
{
  options = {
    machine.core.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.core.enable {
    machine = {
      # add pam, yubikey, secrets, ssh, lanzaboote, persistence, disko, (apparmor?), coolercontrol, monitoring
      bluetooth.enable = true;
      bolt.enable = true;
      fstrim.enable = true;
      fwupd.enable = true;
      hardening.enable = true;
      home-manager.enable = true;
      i18n.enable = true;
      networkmanager.enable = true;
      nix-ld.enable = true;
      nix.enable = true;
      pipewire.enable = true;
      plymouth.enable = true;
      printing.enable = true;
      sudo-rs.enable = true;
      systemd-boot.enable = true;
      tailscale.enable = true;
    };      

    users.mutableUsers = false;
    users.users.root = {
      hashedPassword = "!";
    };
    
    boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  };
}
