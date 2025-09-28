{ ... }: 
{
  networking.hostName = "athena";

  machine.core.enable = true;

  machine.traefik.enable = true;
  machine.postgresql.enable = true;
  machine.redis.enable = true;
  machine.glance.enable = true;
  machine.grub.enable = true;

  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ map (moduleFile: ./users + ("/" + moduleFile)) (builtins.attrNames (builtins.readDir ./users));

  system.stateVersion = "25.05";
}