{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.tools.rice;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.tools.rice = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ 
      asciiquarium
      cbonsai
      cava
      cmatrix
      cowsay
      fortune
      fastfetch
      nitch
      pipes-rs
      scope-tui
      tenki
      terminal-colors
    ];
  };
}