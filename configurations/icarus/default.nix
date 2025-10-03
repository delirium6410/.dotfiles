{ lib, ... }: 
{
  networking.hostName = "icarus";

  machine.core.enable = true;
  machine.core.laptop = true;
  machine.hidpi.enable = true;
  
  machine.cpu-intel.enable = true;
  machine.gpu-intel.enable = true;

  machine.kde.enable = true;
  machine.stylix.enable = true;

  boot.kernel.sysctl = lib.mkForce {
    "vm.swappiness" = 80;
  };

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
