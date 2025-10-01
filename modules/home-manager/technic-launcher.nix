{ config, pkgs, lib, inputs, ... }:
{
  options = {
    machine.technic-launcher.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.technic-launcher.enable {
    home.packages = with pkgs; [ inputs.nix-gaming.packages.${pkgs.system}.technic-launcher ];
  };
}