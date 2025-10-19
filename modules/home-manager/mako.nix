{ config, lib, pkgs, ... }:
{
  options = {
    machine.mako.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.mako.enable {
    services.mako = {
      enable = true;
      settings = {
        anchor = "top-right";
        icons = true;
        border-radius = 0;
        default-timeout = 5000;
      };
    };
  };
}