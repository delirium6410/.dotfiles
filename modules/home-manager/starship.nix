{ config, lib, ... }: 
{
  options = {
    machine.starship.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.starship.enable {
    programs.starship = {
      enable = true;
      enableTransience = true;
      settings = {
        nix_shell.heuristic = true;
        shlvl.disabled = false;
      };
    };
  };
}
