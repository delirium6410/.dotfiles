{ config, lib, pkgs, ... }: 
{
  options = {
    machine.bash.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.bash.enable {
    programs.bash = { 
      enable = true;
      enableCompletion = true;
      historyFile = "$HOME/.local/state/bash_history";
      
      initExtra = ''
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --ignore-file $HOME/.config/fd/ignore . $HOME'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND='fd --type d --hidden --ignore-file $HOME/.config/fd/ignore . $HOME'

        export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --height=60% --layout=reverse --border --preview='bat --color=always --style=numbers {}' --preview-window=right:50% --bind=ctrl-/:toggle-preview"
      '';
    };
  };
}
