{ config, pkgs, lib, ... }:
{
  options = {
    system.gpu_intel.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.system.gpu_intel.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
      ];
      hardware.graphics.extraPackages32 = with pkgs.pkgsi686Linux; [ 
        intel-vaapi-driver 
      ];
    };
  };
}