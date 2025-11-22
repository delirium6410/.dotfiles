{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.system.laptop;
  inherit (lib) mkEnableOption mkIf mkForce;
in
{
  options.modules.system.laptop = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    services.fprintd.enable = mkForce false;
    services.thermald.enable = true;

    services.libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        disableWhileTyping = false;
        additionalOptions = ''
          Option "PressureMotionMinFactor" "0.5"
          Option "PressureMotionMaxFactor" "2.0"
        '';
      };
    };

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