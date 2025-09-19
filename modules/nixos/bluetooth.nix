{ config, pkgs, lib, ... }:
{
  options = {
    machine.bluetooth.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = lib.mkForce false;
    };
  };
}