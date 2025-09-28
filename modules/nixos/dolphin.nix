{ config, pkgs, lib, ... }:
{
  options = {
    machine.dolphin.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.dolphin.enable {
    environment.systemPackages = with pkgs;[
      kdePackages.dolphin

      kdePackages.ark
      p7zip
      unrar
      unzip

      cifs-utils
      samba
    ];
    
    services.gvfs.enable = true;
  };
}