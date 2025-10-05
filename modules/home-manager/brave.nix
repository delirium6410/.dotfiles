{ config, pkgs, lib, ... }:
{
  options = {
    machine.brave.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.brave.enable {
    home.packages = with pkgs; [ brave ];
  };
}
