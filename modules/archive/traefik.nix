{ config, pkgs, lib, ... }:
{
  options = {
    machine.traefik.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.traefik.enable {
    services.traefik = {
      enable = true;
    };
  };
}