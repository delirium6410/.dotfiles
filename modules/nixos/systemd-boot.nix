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
        verbose = true;
      };
    };
  };
}