{ config, pkgs, lib, ... }:
{
  options = {
    machine.retroarch.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.retroarch.enable {
    environment.systemPackages = with pkgs; [
      (retroarch.withCores (cores: with cores; [
        melonds
        mgba
        snes9x2010
      ]))
    ];
  };
}