{ config, pkgs, lib, ... }:
{
  options = {
    machine.gaming.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.gaming.enable {
    #machine.audio-tweak.enable
    #machine.gamemode.enable
    #machine.gamescope.enable

    #machine.wine.enable
    #machine.proton.enable
    #machine.umu-launcher.enable
    
    # maybe use them for profiles instead of general config, 3head
    #machine.steam.enable
    #machine.retroarch.enable

    #machine.platformOptimizations.enable 
    #machine.pipewireLowLatency.enable
  };
}