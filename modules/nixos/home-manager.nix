{ config, pkgs, lib, ... }:
{
  options = {
    machine.home-manager.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.home-manager.enable {
    environment.systemPackages = [ pkgs.home-manager ];
    home-manager = {
      backupFileExtension = "hm-backup";
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}