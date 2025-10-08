{ config, pkgs, lib, ... }:
{
  options = {
    machine.placeholder.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.placeholder.enable {
  };

  options = {
    machine.placeholder = {
      enable = lib.mkEnableOption "";
    };
    machine.placeholder = {
      enable = lib.mkEnableOption "";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.machine.placeholder.enable {

    })
    (lib.mkIf config.machine.placeholder.enable {

    })
  ];  
}