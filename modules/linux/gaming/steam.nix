{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.gaming.steam;
  inherit (lib) mkEnableOption mkIf;
in
{
  imports = [
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

  options.modules.gaming.steam = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    modules.unfreePackages = [ "steam" "steam-original" "steam-unwrapped" "steam-run" ];
    
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