{ config, lib, inputs, ... }: 
{
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];
  
  options = {
    machine.pipewire.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.pipewire.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;    
         
      # https://github.com/fufexan/nix-gaming
      lowLatency = lib.mkIf config.machine.gaming.enable {
        enable = true;
        quantum = 64;
        rate = 48000;
      };
    };
  };
}
