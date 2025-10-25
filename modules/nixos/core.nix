{ config, lib, pkgs, ... }:
# add pam, yubikey, secrets, ssh, lanzaboote, persistence, disko
{
  options = {
    machine.core.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.core.enable {
    users.mutableUsers = false;
    users.users.root = {
      hashedPassword = "!";
    };

    machine = {
      bluetooth.enable = true;
      hardening.enable = true;
      home-manager.enable = true;
      i18n.enable = true;
      networkmanager.enable = true;
      nix.enable = true;
      pipewire.enable = true;
      plymouth.enable = true;
      printing.enable = true;
      systemd-boot.enable = true;
      tailscale.enable = true;
      zsh.enable = true;
    };      
    
    services.fstrim.enable = true;
    services.hardware.bolt.enable = true;
    
    services.fwupd.enable = true;
    hardware.enableRedistributableFirmware = true;

    boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_zen;
  };
}
