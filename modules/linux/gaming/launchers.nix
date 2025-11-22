{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.gaming.launchers;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.gaming.launchers = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.heroic
      pkgs.lutris
      inputs.nix-gaming.packages.${pkgs.system}.wine-discord-ipc-bridge
      inputs.nix-gaming.packages.${pkgs.system}.wine-mono
      inputs.nix-gaming.packages.${pkgs.system}.wine-cachyos
      inputs.nix-gaming.packages.${pkgs.system}.wine-tkg
      pkgs.wineWowPackages.waylandFull
      pkgs.winetricks
      pkgs.vkbasalt
    ];
    
    # Temporary lutris compatibility fixes
    nixpkgs.config.permittedInsecurePackages = [
      "mbedtls-2.28.10"
    ];
  };
}