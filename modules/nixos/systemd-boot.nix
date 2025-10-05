{ config, pkgs, lib, ... }:
{
  options = {
    machine.systemd-boot.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.systemd-boot.enable {
    boot = {
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot = {
          enable = true;
          editor = false;
          timeout = 3;
          configurationLimit = 5;
        };
      };
      initrd = {
        systemd.enable = true;
        verbose = false;
      };
    };
  };
}