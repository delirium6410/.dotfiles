{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop.tuigreet;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.desktop.tuigreet = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
          user = "greeter";
        };
      };
    };
  };
}