{ config, pkgs, lib, ... }:
{
  options = {
    machine.nemo.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.nemo.enable {
    environment.systemPackages = with pkgs; [
      nemo-with-extensions 
      ffmpegthumbnailer
      
      nemo-fileroller
      p7zip
      unrar
      unzip
      zip

      ffmpeg
      samba4Full
    ];
    
    services.gvfs.enable = true;
  };
}