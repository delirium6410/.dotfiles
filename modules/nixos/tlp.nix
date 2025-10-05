{ config, lib, pkgs, ... }:
{
  options = {
    machine.tlp.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.tlp.enable {
    services.power-profiles-daemon.enable = false;
    services.tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 70;
        STOP_CHARGE_THRESH_BAT0 = 80;

        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_BOOST_ON_AC = 1;

        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
        CPU_BOOST_ON_BAT = 1;

        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "balanced";

        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "on";

        RUNTIME_PM_DRIVER_DENYLIST = "i915 nvme";
      };
    };
  };
}
