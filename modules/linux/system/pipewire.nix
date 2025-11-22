{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.system.pipewire;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.system.pipewire = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;    
    };
  };
}