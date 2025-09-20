{ config, pkgs, lib, ... }:
{
  options = {
    system.gpu_amd.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.system.gpu_amd.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
  };
}