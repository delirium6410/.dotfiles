{ config, pkgs, lib, ... }:
{
  options = {
    machine.yubikey.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.yubikey.enable {
    hardware.gpgSmartcards.enable = true;
    programs.ssh.startAgent = true;

    environment.systemPackages = with pkgs; [
      yubikey-manager
      yubikey-personalization
      yubico-pam
    ];

    security.pam.u2f.enable = true;
  };
}