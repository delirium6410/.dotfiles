{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop.cliphist;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.desktop.cliphist = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [
        wl-clip-persist
      ];

      services.cliphist = {
        enable = true;
        extraOptions = [
          "-max-items"
          "250"
          "-max-dedupe-search"
          "250"
        ];
      };
    };
  };
}