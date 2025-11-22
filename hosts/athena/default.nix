{ ... }:
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "athena";

  modules = {
    profiles.gaming.enable = true;

    desktop.hyprland.enable = true;
    
    system.cpu.intel.enable = true;
    system.gpu.amd.enable = true;
  };
}
