{ config, pkgs, lib, ... }:
{
  options = {
    machine.airshipper.enable = lib.mkEnableOption "";
    machine.prismlauncher.enable = lib.mkEnableOption "";
    machine.osu.enable = lib.mkEnableOption "";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.machine.airshipper.enable {
      home.packages = with pkgs; [ airshipper ];
    })
    (lib.mkIf config.machine.prismlauncher.enable {
      home.packages = with pkgs; [ prismlauncher ];
    })
    (lib.mkIf config.machine.osu.enable {
      home.packages = with pkgs; [ osu-lazer-bin ];
    })
  ];  
}