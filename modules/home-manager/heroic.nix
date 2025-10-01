{ config, pkgs, lib, ... }:
{
  options = {
    machine.heroic.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.heroic.enable {
    home.packages = with pkgs; [ heroic ];
  };
}