{ config, lib, ... }: 
{
  options = {
    machine.bat.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.bat.enable {
    programs.bat.enable = true;
    home.shellAliases.cat = "bat";
  };
}
