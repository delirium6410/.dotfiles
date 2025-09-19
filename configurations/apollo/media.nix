{ ... }: 
{
  networking.hostName = "homelab";

  homelab.core.enable = true;
  
# combine into media.enable = true
  homelab.audiobookshelf.enable = true;
  homelab.stirling-pdf.enable = true;  
  homelab.navidrome.enable = true;
  homelab.jellyfin.enable = true;
  homelab.calibre.enable = true;
  homelab.komga.enable = true;  

  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ map (moduleFile: ./users + ("/" + moduleFile)) (builtins.attrNames (builtins.readDir ./users));
  
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  system.stateVersion = "25.05";
}