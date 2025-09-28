{ config, lib, ... }: 
{
  options = {
    machine.navi.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.navi.enable {
    programs.navi = {
      enable = true;
    };
  };
}
