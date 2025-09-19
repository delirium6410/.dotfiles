{ config, pkgs, lib, ... }:
{
  options = {
    machine.glance.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.glance.enable {
    services.glance = {
      enable = true;
    };
  };
}