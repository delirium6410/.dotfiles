{ config, pkgs, lib, ... }:
{
  options = {
    machine.systemd-boot.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.systemd-boot.enable {
    boot = {
      loader = {
        efi.canTouchEfiVariables = true;
        timeout = 0;
        systemd-boot = {
          enable = true;
          editor = false;
          configurationLimit = 5;
          memtest86.enable = true;
        };
      };
      initrd = {
        systemd.enable = true;
        verbose = false;
      };
      consoleLogLevel = 0;
    };
    systemd.extraConfig = "DefaultTimeoutStopSec=10s";

    # don't wait for all udev events to be processed
    # before continuing boot process decreases boot time
    # but double check if it causes problems
    # systemctl --failed / journalctl -b | grep -i "failed\|error"
    systemd.services.systemd-udev-settle.enable = false;
  };
}