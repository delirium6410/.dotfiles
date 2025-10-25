{ config, lib, pkgs, ... }:
{
  options = {
    machine.laptop.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.laptop.enable {
    machine.tlp.enable = true;

    services.fprintd.enable = false; # fprintd-enroll, hella long boot times after enabling it
    services.thermald.enable = true;

    services.upower = {
      percentageLow = 15; 
      percentageCritical = 5;
      percentageAction = 3;
      criticalPowerAction = "Hibernate";
    };

    boot = {
      kernelParams = [ "mem_sleep_default=deep" ];
    };

    services.logind = {
      lidSwitch = "suspend";
      lidSwitchExternalPower = "suspend";
      extraConfig = ''
        HandlePowerKey=suspend
        HibernateDelaySec=500
        SuspendState=mem
      '';
    };

    systemd.services = {
      telephony_client.enable = false;
      geoclue.enable = false;
    };
  };
}
