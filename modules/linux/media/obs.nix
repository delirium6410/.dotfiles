{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.media.obs;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.media.obs = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-websocket
        obs-move-transition
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };
  };
}