{ config, pkgs, lib, ... }:
{
  options = {
    machine.redis.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.redis.enable {
    services.redis.servers = {
      enable = true;
    };
  };
}