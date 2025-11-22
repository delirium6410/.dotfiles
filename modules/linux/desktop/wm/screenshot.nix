{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop.screenshot;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.desktop.screenshot = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [
        grim
        slurp
        swappy
      ];

      xdg.configFile."swappy/config".text = ''
        [Default]
        save_dir=$HOME/Pictures/Screenshots
        save_filename_format=screenshot_%Y%m%d_%H%M%S.png
        show_panel=true
        line_size=5
        text_size=20
        text_font=DejaVu Sans
      '';
    };
  };
}