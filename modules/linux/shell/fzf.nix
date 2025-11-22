{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.shell.fzf;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.shell.fzf = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
      };
      
      programs.zsh.initContent = ''
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --ignore-file $HOME/.config/fd/ignore . $HOME'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND='fd --type d --hidden --ignore-file $HOME/.config/fd/ignore . $HOME'

        export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --height=60% --layout=reverse --border --preview='bat --color=always --style=numbers {}' --preview-window=right:50% --bind=ctrl-/:toggle-preview"
      '';
    };
  };
}