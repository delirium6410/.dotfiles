{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.gaming.retroarch;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.gaming.retroarch = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (retroarch.withCores (cores: with cores; [
        melonds
        mgba
        snes9x2010
      ]))
    ];
  };
}