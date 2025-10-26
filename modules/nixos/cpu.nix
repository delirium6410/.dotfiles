{ config, pkgs, lib, ... }:
{
  options = {
    machine.cpu_amd.enable = lib.mkEnableOption "";
    machine.cpu_intel.enable = lib.mkEnableOption "";
  };

  config = lib.mkMerge [
    (lib.mkIf config.machine.cpu_amd.enable {
      hardware.cpu.amd.updateMicrocode = true;
      boot.kernelParams = [ "amd_pstate=active" ];
      boot.kernelModules = [ "kvm-amd" ];
    })
    (lib.mkIf config.machine.cpu_intel.enable {
      hardware.cpu.intel.updateMicrocode = true;
      environment.systemPackages = with pkgs; [ 
        iucode-tool
      ];
      boot.kernelParams = [ "intel_pstate=active" ];
      boot.kernelModules = [ "kvm-intel" ];
    })
  ];
}