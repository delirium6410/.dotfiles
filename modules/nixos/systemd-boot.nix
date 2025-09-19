{ config, pkgs, lib, ... }:
{
  options = {
    machine.systemd-boot.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.systemd-boot.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;  
  };
}