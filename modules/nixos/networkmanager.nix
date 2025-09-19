{ config, pkgs, lib, ... }:
{
  options = {
    machine.networkmanager.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.networkmanager.enable {
    networking.networkmanager.enable = true;
  };
}