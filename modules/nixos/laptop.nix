{ config, lib, pkgs, ... }:
{
  options = {
    machine.laptop.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.laptop.enable {
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
  };
}
