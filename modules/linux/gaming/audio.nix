{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.modules.gaming.audio;
  inherit (lib) mkEnableOption mkIf;
in
{
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  options.modules.gaming.audio = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire.lowLatency = {
      enable = true;
      quantum = 64;
      rate = 48000;
    };
  };
}