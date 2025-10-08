{ config, lib, pkgs, ... }:
{
  options = {
    machine.monolith.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.monolith.enable {
    home.packages = with pkgs; [ monolith ];
  };
}