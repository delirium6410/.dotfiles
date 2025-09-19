{ ... }: 
{
  networking.hostName = "homelab";

  homelab.core.enable = true;

  homelab.nextcloud.enable = true;
  homelab.immich.enable = true;
  homelab.vaultwarden.enable = true;
  homelab.syncthing.enable = true;
  homelab.searxng.enable = true;
  homelab.paperlessngx.enable = true;
  # linkwarden andother similar bookmarking tools would be great

  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ map (moduleFile: ./users + ("/" + moduleFile)) (builtins.attrNames (builtins.readDir ./users));

  system.stateVersion = "25.05";
}