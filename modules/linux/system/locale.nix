{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.system.locale;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  options.modules.system.locale = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    services.automatic-timezoned.enable = mkDefault true;
    services.timesyncd.enable = true;
    networking.timeServers = [
      "0.nixos.pool.ntp.org"
      "1.nixos.pool.ntp.org"
      "2.nixos.pool.ntp.org"
      "3.nixos.pool.ntp.org"
    ];

    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };

    i18n.extraLocales = [
      "en_US.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
    ];

    console.keyMap = "de";
    services.xserver.xkb = {
      layout = "de";
      variant = "";
    };
  };
}