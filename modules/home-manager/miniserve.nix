{ config, lib, pkgs, ... }:
{
  options = {
    machine.miniserve.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.miniserve.enable {
    home.packages = with pkgs; [ miniserve ];
  };
}