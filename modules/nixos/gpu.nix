{ config, pkgs, lib, ... }:
{
  options = {
    machine.gpu_amd.enable = lib.mkEnableOption "";
    machine.gpu_intel.enable = lib.mkEnableOption "";
  };

  config = lib.mkMerge [
    (lib.mkIf config.machine.gpu_amd.enable {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        
        extraPackages = with pkgs; [
          rocmPackages.clr.icd
        ];
      };

      environment.variables = {
        AMD_VULKAN_ICD = "RADV";
        LIBVA_DRIVER_NAME = "radeonsi";
        VDPAU_DRIVER = "radeonsi";
      };

      # services.lact.enable = true;

      # boot.kernelParams = [
      #   "amdgpu.ppfeaturemask=0x4000"
      # ];
    })
    (lib.mkIf config.machine.gpu_intel.enable {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;      
        extraPackages = with pkgs; [
          intel-media-driver
          intel-vaapi-driver
          intel-compute-runtime
          vpl-gpu-rt
        ];
        
        extraPackages32 = with pkgs; [
          intel-media-driver
          intel-vaapi-driver
        ];
      };

      environment.systemPackages = with pkgs; [
        libvdpau-va-gl
      ];
      
      environment.variables = {
        LIBVA_DRIVER_NAME = "iHD";      
        VDPAU_DRIVER = "va_gl";
      };

      boot.initrd.kernelModules = [ "i915" ];
      boot.kernelModules = [ "i915" ];
      boot.kernelParams = [
        "i915.enable_fbc=1"
        "i915.fastboot=1"
        "i915.enable_dc=0"
      ];
      boot.extraModprobeConfig = ''
        options i915 enable_guc=3
      '';
    })
  ];
}