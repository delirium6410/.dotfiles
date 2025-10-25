{ lib, inputs, nixos-hardware, ... }: 
{
  networking.hostName = "icarus";

  machine.core.enable = true;
  machine.laptop.enable = true;

  machine.sshd.enable = true;
  machine.yubikey.enable = true;
  
  machine.cpu_intel.enable = true;
  #machine.gpu_intel.enable = true;
  machine.hyprland.enable = true;
  machine.kde.enable = true;
  machine.stylix.enable = true;
  machine.gaming.enable = true;



  imports =
    [
      ./hardware-configuration.nix
      "${inputs.nixos-hardware}/lenovo/thinkpad/p1/3th-gen"
    ]
    ++ map (moduleFile: ./users + ("/" + moduleFile)) (builtins.attrNames (builtins.readDir ./users));
  
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };
  
  system.stateVersion = "25.05";
}
