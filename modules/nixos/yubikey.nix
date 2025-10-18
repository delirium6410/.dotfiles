{ config, pkgs, lib, ... }:
{
  options = {
    machine.yubikey.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.yubikey.enable {
    environment.systemPackages = with pkgs; [
      yubikey-manager
      yubikey-personalization
      yubico-piv-tool
      yubioath-flutter
    ];

    services = {
      pcscd = {
        enable = true;
        plugins = [ pkgs.yubikey-personalization ];
      };
      udev.packages = [ pkgs.yubikey-personalization ];
    };

    hardware.gpgSmartcards.enable = true;
  };
}