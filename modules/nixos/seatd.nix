{ config, lib, pkgs, ... }: 
{
  options = {
    machine.seatd.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.seatd.enable {
    systemd.services = {
      seatd = {
        enable = true;
        description = "Seat management daemon";
        script = "${pkgs.seatd}/bin/seatd -g wheel";
        serviceConfig = {
          Type = "simple";
          Restart = "always";
          RestartSec = "1";
        };
        wantedBy = [ "multi-user.target" ];
      };
    };  
  };
}
