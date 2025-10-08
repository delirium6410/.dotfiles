{ config, pkgs, lib, ... }:
{
  options = {
    machine.i18n.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.i18n.enable {
    services.automatic-timezoned.enable = true;
    networking.timeServers = ["pool.ntp.org"];
    time.hardwareClockInLocalTime = true;
    
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocales = [
      "en_US.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
    ];

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

    console.keyMap = "de";
    services.xserver.xkb = {
      layout = "de";
      variant = "";
    };
  };
}