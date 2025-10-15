{ lib, config, aagl, ... }:
{
  options = {
    machine.anime-game-launcher.enable = lib.mkEnableOption "";
    machine.honkers-railway-launcher.enable = lib.mkEnableOption "";
  };

  config = lib.mkMerge [
    (lib.mkIf config.machine.anime-game-launcher.enable {
      programs.anime-game-launcher.enable = true;
    })
    (lib.mkIf config.machine.honkers-railway-launcher.enable {
      programs.honkers-railway-launcher.enable = true;
    })
  ];
}