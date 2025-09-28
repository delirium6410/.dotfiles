{ config, pkgs, lib, ... }:
{
  options = {
    machine.obsidian.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.obsidian.enable {
    home.packages = with pkgs; [ obsidian ];
  };
}
