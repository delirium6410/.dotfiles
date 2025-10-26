{ config, pkgs, lib, ... }:
# https://wiki.archlinux.org/title/File_manager_functionality#Additional_features
{
  options = {
    machine.nautilus.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.nautilus.enable {
    environment.systemPackages = with pkgs; [
      nautilus
      ffmpegthumbnailer
      
      p7zip
      unrar
      unzip
      zip

      ffmpeg
      samba4Full
      #tracker
    ];
    
    services.gvfs.enable = true;
    #programs.dconf.enable = true;
  };
}