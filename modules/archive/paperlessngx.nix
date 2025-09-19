{ config, pkgs, lib, ... }:
{
  options = {
    machine.paperlessngx.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.paperlessngx.enable {
    services.paperless = {
      enable = true;
      domain = "";
      evironmentFile = "";
      settings = {};
    };
  };
}