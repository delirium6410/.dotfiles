{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.profiles.gaming;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.profiles.gaming = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    modules = {
      profiles.desktop.enable = true;

      gaming.gamemode.enable = true;
      gaming.audio.enable = true;
      gaming.hardware.enable = true;
      gaming.kernel.enable = true;
      
      gaming.steam.enable = true;
      gaming.launchers.enable = true;
    };
  };
}