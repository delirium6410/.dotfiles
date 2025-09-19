{ config, pkgs, lib, ... }:
{
  options = {
    machine.nextcloud.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.nextcloud.enable {
    services.nextcloud = {
      enable = true;
      https = true;
      package = with pkgs; [ nextcloud30 ];
      settings = {};
      database = {};
      config = {};
      secretsFile = {};
    };
  };
}