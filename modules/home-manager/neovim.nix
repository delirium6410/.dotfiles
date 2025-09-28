{ config, lib, ... }: 
{
  options = {
    machine.neovim.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.neovim.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    #home.sessionVariables.EDITOR = "nvim";
  };
}
