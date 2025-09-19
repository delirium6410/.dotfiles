{ ... }: 
{
  networking.hostName = "homelab";

  machine.core.enable = true;
  machine.authentik.enable = true;
  machine.intel-arc-a380.enable = true;
  machine.systemd-boot.enable = true;
  machine.postgresql.enable = true;

  machine.flaresolverr.enable = true;
  machine.overseerr.enable = true;
  machine.qbittorrent.enable = true;
  machine.sabnzbd.enable = true; 
  machine.prowlarr.enable = true;
  machine.bazarr.enable = true;
  machine.sonarr.enable = true;
  machine.radarr.enable = true;
  machine.readarr.enable = true;
  machine.lidarr.enable = true;
  machine.whisparr.enable = true;

  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ map (moduleFile: ./users + ("/" + moduleFile)) (builtins.attrNames (builtins.readDir ./users));
  
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  system.stateVersion = "25.05";
}