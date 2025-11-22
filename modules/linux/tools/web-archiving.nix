{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.tools.web-archiving;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.tools.web-archiving = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ 
      monolith
      archivebox
      gallery-dl
      tubesync
      yt-dlp
    ];
  };
}