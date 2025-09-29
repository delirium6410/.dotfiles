{ config, lib, ... }: 
{
  options = {
    machine.ripgrep.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.ripgrep.enable {
    programs.ripgrep.enable = true;
  };
}