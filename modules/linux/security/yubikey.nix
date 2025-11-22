{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.security.yubikey;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.security.yubikey = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
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