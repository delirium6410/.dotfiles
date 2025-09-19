{ config, pkgs, lib, ... }:
{
  options = {
    machine.immich.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.immich.enable {
    services.immich = {
      enable = true;
      mediaLocation = "";
      environment = {};
      machine-learning = {};
      settings = {};
      database = {};
      redis = {};
    };
  };
}