{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.desktop.hyprlock;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf mkForce;
in
{
  options.modules.desktop.hyprlock = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.hyprlock = {
        enable = true;
        settings = {
          general = {
            grace = 5;
            hide_cursor = true;
            no_fade_in = false;
          };
          
          label = [
            {
              monitor = "";
              text = "cmd[update:1000] echo \"$(date +\"%H:%M\")\"";
              color = "rgb(${config.lib.stylix.colors.base05})";
              font_size = 90;
              font_family = "DejaVu Sans";
              position = "0, 250";
              halign = "center";
              valign = "center";
            }
            {
              monitor = "";
              text = "cmd[update:43200000] echo \"$(date +\"%A, %B %d\")\"";
              color = "rgb(${config.lib.stylix.colors.base04})";
              font_size = 25;
              font_family = "DejaVu Sans";
              position = "0, 150";
              halign = "center";
              valign = "center";
            }
          ];
        };
      };
    };
  };
}