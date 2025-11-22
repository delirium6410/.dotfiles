{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.shell.ghostty;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.shell.ghostty = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.ghostty = {
        enable = true;
        enableZshIntegration = true;
        installBatSyntax = true;
        installVimSyntax = true;
        clearDefaultKeybinds = false;
      };
      
      home.sessionVariables = {
        TERMINAL = "ghostty";
      };
    };
  };
}