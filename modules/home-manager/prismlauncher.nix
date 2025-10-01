{ config, pkgs, lib, ... }:
{
  options = {
    machine.prismlauncher.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.prismlauncher.enable {
    home.packages = with pkgs; [ prismlauncher ];
  };
}