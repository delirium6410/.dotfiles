{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.tools.btop;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.tools.btop = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.btop = {
        enable = true;
        settings = {
          rounded_corners = true;
          theme_background = false;
          graph_symbol = "braille";
          clock_format = "%H:%M";
          shown_boxes = "proc cpu mem net";
          update_ms = 100;
        };
      };
    };
  };
}