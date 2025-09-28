{ config, lib, ... }: 
{
  options = {
    machine.zoxide.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.zoxide.enable {
    programs.zoxide.enable = true;
  };
}
