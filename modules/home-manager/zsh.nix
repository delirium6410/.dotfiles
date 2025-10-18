{ config, pkgs, lib, ... }:
{
  options = {
    machine.zsh.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.zsh.enable {
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

      initContent = ''
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --ignore-file $HOME/.config/fd/ignore . $HOME'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND='fd --type d --hidden --ignore-file $HOME/.config/fd/ignore . $HOME'

        export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --height=60% --layout=reverse --border --preview='bat --color=always --style=numbers {}' --preview-window=right:50% --bind=ctrl-/:toggle-preview"
      '';
    };
  };
}