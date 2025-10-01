{ config, pkgs, lib, ... }:
{
  options = {
    machine.gaming.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.gaming.enable {
    machine = {
      lutris.enable = true;
      heroic.enable = true;

      airshipper.enable = true;
      osu.enable = true;
      prismlauncher.enable = true;
      technic-launcher.enable = true;
    };
  };
}