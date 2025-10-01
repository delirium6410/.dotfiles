{ config, lib, ... }:
{
  options = {
    machine.printing.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.printing.enable {
    services.printing.enable = true;
    services.avahi = {
      enable = true;
      nssmdns4 = true;
    };
  };
}
