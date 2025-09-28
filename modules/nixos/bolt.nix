{ config, lib, ... }: 
{
  options = {
    machine.bolt.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.bolt.enable {
    services.hardware.bolt.enable = true;
  };
}
