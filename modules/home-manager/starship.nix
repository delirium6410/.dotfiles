{ config, lib, ... }: 
{
  options = {
    machine.starship.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.starship.enable {
    programs.starship = {
      enable = true;
      enableBashIntegration = lib.mkIf config.machine.bash.enable true;
      enableZshIntegration = lib.mkIf config.machine.Zsh.enable true;
      enableTransience = true;
      settings = {
        nix_shell.heuristic = true;
        shlvl.disabled = false;
      };
    };
  };
}
