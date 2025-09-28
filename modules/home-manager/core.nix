{ config, lib, ... }: 
{
  options = {
    machine.core.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.core.enable {
    # ssh, git, monolith, miniserve, benchmarking/monitoring, archiving, fd, ?
    machine.bash.enable = true;
    machine.bat.enable = true;
    machine.direnv.enable = true;
    machine.eza.enable = true;
    machine.ghostty.enable = true;
    machine.git.enable = true;
    machine.navi.enable = true;
    machine.ripgrep.enable = true;
    machine.starship.enable = true;
    machine.neovim.enable = true;
    machine.xdg-userdirs.enable = true;
    machine.zoxide.enable = true;

    programs.home-manager.enable = true;
  };
}
