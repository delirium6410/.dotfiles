{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    inputs.nix-gaming.nixosModules.wine
  ];

  options = {
    machine.wine.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.wine.enable {
    programs.wine = {
      enable = true;
      binfmt.enable = true;
      ntsync.enable = true;
      package = with pkgs; [ wine-tkg-ntsync ];
    };
  };
}