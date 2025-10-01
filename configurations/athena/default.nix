{ ... }: 
{
  networking.hostName = "athena";

  machine.core.enable = true;
  machine.gaming.enable = true;
  
  machine.cpu-intel.enable = true;
  machine.gpu-amd.enable = true;

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
