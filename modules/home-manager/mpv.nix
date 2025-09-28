{ config, lib, ... }: 
{
  options = {
    machine.mpv.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.mpv.enable {
    programs.mpv.enable = true;
  };
}
