{ ... }: 
{
  networking.hostName = "athena";

  machine.core.enable = true;
  machine.gaming.enable = true;
  
  machine.cpu_intel.enable = true;
  machine.gpu_amd.enable = true;

  machine.kde.enable = true;
  machine.stylix.enable = true;

  powerManagement.cpuFreqGovernor = "performance";
  
  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ map (moduleFile: ./users + ("/" + moduleFile)) (builtins.attrNames (builtins.readDir ./users));
  
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };
  
  system.stateVersion = "25.05";
}
