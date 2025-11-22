{ ... }:
{
  imports = [ ../../disko/layouts/simple-uefi.nix ];

  networking.hostName = "test";

  modules = {
    profiles.base.enable = true;
  };
}
