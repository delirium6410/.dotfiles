{ config, lib, pkgs, ... }:
{
  options = {
    machine.laptop.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.laptop.enable {
    boot = {
      kernelParams = [ "mem_sleep_default=deep" ];
      initrd.systemd.enable = true;
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
