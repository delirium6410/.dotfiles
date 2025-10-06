{ lib, ... }: 
{
  networking.hostName = "icarus";

  machine.core.enable = true;
  machine.laptop.enable = true;
  machine.hidpi.enable = true;
  
  machine.cpu_intel.enable = true;
  machine.gpu_intel.enable = true;

  machine.kde.enable = true;
  machine.stylix.enable = true;

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
