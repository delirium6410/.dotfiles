{ config, pkgs, lib, ... }:
{
  options = {
    machine.searxng.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.searxng.enable {
    services.searx = {
      enable = true;
      domain = "";
      evironmentFile = "";
      settings = {};
    };
  };
}