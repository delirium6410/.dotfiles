{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

  options = {
    machine.steam.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.steam.enable {
    programs.steam = {
      enable = true;
      extraPackages = with pkgs; [ 
        steamtinkerlaunch 
      ];
      platformOptimizations = { 
        enable = true;
      };
    };
    environment.systemPackages = with pkgs; [ umu-launcher ];
  };
}