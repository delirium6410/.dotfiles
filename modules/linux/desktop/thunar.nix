{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop.thunar;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.desktop.thunar = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    modules.unfreePackages = [ "unrar" ];
    
    programs = {
      thunar.enable = true;
      thunar.plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    
    environment.systemPackages = with pkgs; [
      # Archiving
      file-roller
      kdePackages.ark
      p7zip
      unrar
      unzip
      zip
      
      # SMB/NFS
      samba4Full
      cifs-utils
      nfs-utils
      
      # Thumbnails
      ffmpegthumbnailer
      webp-pixbuf-loader
      librsvg
    ];
    
    services = {
      tumbler.enable = true;  
      gvfs.enable = true;    
      udisks2 = {
        enable = true;
        mountOnMedia = true;
      };
    };
    
    environment.sessionVariables = {
      TUMBLER_CACHE_SIZE = "512MB"; # Faster thumbnail generation      
      THUNAR_USE_ASYNC_IO = "1"; # Better file operations
    };
  };
}