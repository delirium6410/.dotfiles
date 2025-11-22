{
  config,
  lib,
  ...
}:
let
  cfgAmd = config.modules.system.cpu.amd;
  cfgIntel = config.modules.system.cpu.intel;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.system.cpu = {
    amd.enable = mkEnableOption "";
    intel.enable = mkEnableOption "";
  };

  config = lib.mkMerge [
    (mkIf cfgAmd.enable {
      hardware.cpu.amd.updateMicrocode = true;
      boot = {
        kernelParams = [ "amd_pstate=active" ];
        kernelModules = [ "kvm-amd" ];
      };
    })
    (mkIf cfgIntel.enable {
      hardware.cpu.intel.updateMicrocode = true;
      boot = {
        kernelParams = [ "intel_pstate=active" ];
        kernelModules = [ "kvm-intel" ];
      };
    })
  ];
}