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
    };
  };
}
