{ config, pkgs, lib, ... }:
{
  options = {
    machine.gaming.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.gaming.enable {
    #machine.lutris.enable
    #machine.heroic.enable
    #machine.bottles.enable

    #machine.prismlauncher.enable
    #machine.airshipper.enable
    #machine.technic-launcher.enable
    #machine.osu-lazer-bin.enable
    #machine.osu-stable.enable
  };
}