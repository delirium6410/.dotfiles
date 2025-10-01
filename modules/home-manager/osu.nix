{ config, pkgs, lib, ... }:
{
  options = {
    machine.osu.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.osu.enable {
    home.packages = with pkgs; [ 
      inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.osu-stable.override rec {
        wine = wine-osu;
      }
    ];
  };
}