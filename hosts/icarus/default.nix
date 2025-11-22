{ ... }:
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "icarus";

  modules = {
    profiles.laptop.enable = true;

    desktop.hyprland.enable = true;
    
    system.cpu.intel.enable = true;
    system.gpu.intel.enable = true;
  };
}
