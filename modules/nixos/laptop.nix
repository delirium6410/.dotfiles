{ config, lib, pkgs, ... }:
{
  options = {
    machine.laptop.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.laptop.enable {
    machine.tlp.enable = true;

    services.fprintd.enable = true; # fprintd-enroll
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
      lidSwitchExternalPower = "hibernate";
      extraConfig = ''
        HandlePowerKey=poweroff
        HibernateDelaySec=600
        SuspendState=mem
      '';
    };

    systemd.user.services.telephony_client.enable = false;
  };
}
