{ config, pkgs, lib, ... }:
{
  options = {
    machine.airshipper.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.airshipper.enable {
    home.packages = with pkgs; [ airshipper ];
  };
}