{ config, pkgs, lib, ... }:
{
  options = {
    machine.gaming.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.gaming.enable {
    machine = {
      launchers.enable = true;

      osu.enable = true;
      prismlauncher.enable = true;
      airshipper.enable = false;
    };
  };
}