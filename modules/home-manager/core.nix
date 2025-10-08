{ config, lib, ... }: 
{
  options = {
    machine.core.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.core.enable {
    # ssh, monolith, miniserve, benchmarking/monitoring, archiving, fd, ?
    machine.bash.enable = true;
    machine.git.enable = true;
    machine.neovim.enable = true;
    machine.xdg-userdirs.enable = true;

    programs.home-manager.enable = true;
  };
}
