{ config, lib, ... }: 
{
  options = {
    machine.core.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.core.enable {
    # add ssh
    machine.bash.enable = true;
    machine.cli.enable = true;
    machine.git.enable = true;
    machine.neovim.enable = true;
    machine.xdg.enable = true;

    programs.home-manager.enable = true;
  };
}
