{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.development.vscode;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.development.vscode = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    modules.unfreePackages = [ "vscode" ];
    
    home-manager.users.${username} = {
      programs.vscode = {
        enable = true;
        mutableExtensionsDir = false;
        profiles.default = {
          enableUpdateCheck = false;
          enableExtensionUpdateCheck = false;
          extensions = with pkgs.vscode-extensions; [
            bbenoist.nix
          ];
          userSettings = {};
        };
      };
    };
  };
}