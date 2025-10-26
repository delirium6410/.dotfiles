{ config, pkgs, lib, ... }:
# https://wiki.archlinux.org/title/File_manager_functionality#Additional_features
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
      kdePackages.kimageformats
      kdePackages.ffmpegthumbs
      kdePackages.kio-admin
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