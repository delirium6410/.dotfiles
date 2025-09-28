{ config, pkgs, lib, ... }:
{
  options = {
    machine.ghostty.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.ghostty.enable {
    programs.ghostty = {
      enable = true; 
    };
  };
}