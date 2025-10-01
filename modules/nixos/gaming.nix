{ config, pkgs, lib, ... }:
{
  options = {
    machine.gaming.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.gaming.enable {
    machine = {
      gamemode.enable = true;
      gamescope.enable = true;

      retroarch.enable = true;
      steam.enable = true;
      
      wine.enable = true;
    };
  };
}