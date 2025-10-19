{ config, lib, pkgs, ... }:
{
  options = {
    machine.mako.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.mako.enable {
    services.mako = {
      enable = true;
      anchor = "top-right";
      borderRadius = 0;
      defaultTimeout = 5000;
    };
  };
}