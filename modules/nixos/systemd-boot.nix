{ config, pkgs, lib, ... }:
{
  options = {
    machine.systemd-boot.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.systemd-boot.enable {
    boot = {
      loader = {
        efi.canTouchEfiVariables = true;
        timeout = 3;
        systemd-boot = {
          enable = true;
          editor = false;
          configurationLimit = 5;
        };
      };
      initrd = {
        systemd.enable = true;
        verbose = true;
      };
    };
  };
}