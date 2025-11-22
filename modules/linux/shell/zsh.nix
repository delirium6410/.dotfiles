{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.shell.zsh;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.shell.zsh = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    programs.zsh.enable = true;
    environment.shells = with pkgs; [ zsh ];
    environment.pathsToLink = [ "/share/zsh" ];

    home-manager.users.${username} = {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        history = {
          path = "$HOME/.local/state/zsh_history";
          size = 10000;
          save = 10000;
          share = true;
          expireDuplicatesFirst = true;
          ignoreDups = true;
          ignoreSpace = true;
        };
      };
    };
  };
}