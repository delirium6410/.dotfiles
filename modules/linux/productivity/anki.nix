{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.productivity.anki;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.productivity.anki = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [ anki ];
      
      # cooked or cooking, chat?
      # wayland.windowManager.hyprland.settings.bind = lib.mkIf config.modules.desktop.hyprland.enable (lib.mkAfter [
      #   "SUPER, A, exec, anki"
      # ]);
    };
  };
}