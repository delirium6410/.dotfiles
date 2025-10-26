{ config, pkgs, lib, ... }:
{
  options = {
    machine.launchers.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.launchers.enable {
    home.packages = with pkgs; [ 
      heroic
    ];
    programs.lutris = {
      enable = true;
    };
  };
}