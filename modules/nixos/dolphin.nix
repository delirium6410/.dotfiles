{ config, pkgs, lib, ... }:
{
  options = {
    machine.dolphin.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.dolphin.enable {
    environment.systemPackages = with pkgs; [
      kdePackages.dolphin
      kdePackages.baloo
      kdePackages.baloo-widgets
      kdePackages.kdegraphics-thumbnailers
      kdePackages.ffmpegthumbs
      kdePackages.kio-extras
      kdePackages.kio-fuse
      
      kdePackages.ark
      p7zip
      unrar
      unzip
      zip

      ffmpeg
      samba4Full
    ];    
  };
}