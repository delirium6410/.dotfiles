{ config, pkgs, lib, ... }:
{
  options = {
    machine.postgresql.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.postgresql.enable {
    services.postgresql = {
      enable = true;
    };
  };
}