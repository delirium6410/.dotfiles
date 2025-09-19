{ config, pkgs, lib, ... }:
{
  options = {
    machine.vaultwarden.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.vaultwarden.enable {
    services.vaultwarden = {
      enable = true;
      backupDir = "";
      dbBackend = "postgresql";
      environmentFile = "";
      config = {};
    };
  };
}