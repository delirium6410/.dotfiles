{ config, pkgs, lib, ... }:
{
  options = {
    machine.thunar.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.thunar.enable {
    programs.thunar.enable = true;
    programs.thunar.plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
    
    environment.systemPackages = with pkgs; [
      ffmpegthumbnailer
      
      p7zip
      unrar
      unzip
      zip

      ffmpeg
      samba4Full
    ];
    
    services.gvfs.enable = true;
    services.tumbler.enable = true;
  };
}