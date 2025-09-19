{ config, pkgs, lib, ... }:
{
  options = {
    machine.grub.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.grub.enable {
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "nodev";
    boot.loader.grub.efiSupport = true;
    boot.loader.efi.canTouchEfiVariables = true;  };
}