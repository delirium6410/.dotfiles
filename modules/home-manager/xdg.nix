{ config, lib, ... }: 
{
  options = {
    machine.xdg.enable = lib.mkEnableOption "";
  };
  
  config = lib.mkIf config.machine.xdg.enable {
    xdg = {
      userDirs = {
        enable = true;
        createDirectories = true;
        desktop = "${config.home.homeDirectory}/Desktop";
        documents = "${config.home.homeDirectory}/Documents";
        download = "${config.home.homeDirectory}/Downloads";
        music = "${config.home.homeDirectory}/Music";
        pictures = "${config.home.homeDirectory}/Pictures";
        publicShare = "${config.home.homeDirectory}/Public";
        templates = "${config.home.homeDirectory}/Templates";
        videos = "${config.home.homeDirectory}/Videos";
      };

      mimeApps = {
        enable = true;
        defaultApplications = lib.mkMerge [
          (lib.mkIf config.machine.firefox.enable {
            "text/html" = "firefox.desktop";
            "text/xml" = "firefox.desktop";
            "application/xhtml+xml" = "firefox.desktop";
            "application/xml" = "firefox.desktop";
            "application/rss+xml" = "firefox.desktop";
            "application/rdf+xml" = "firefox.desktop";
            "x-scheme-handler/http" = "firefox.desktop";
            "x-scheme-handler/https" = "firefox.desktop";
            "x-scheme-handler/ftp" = "firefox.desktop";
            "x-scheme-handler/chrome" = "firefox.desktop";
            "x-scheme-handler/about" = "firefox.desktop";
            "x-scheme-handler/unknown" = "firefox.desktop";
          })
          
          (lib.mkIf config.machine.neovim.enable {
            "text/plain" = "nvim.desktop";
            "text/x-c" = "nvim.desktop";
            "text/x-c++" = "nvim.desktop";
            "text/x-python" = "nvim.desktop";
            "text/x-shellscript" = "nvim.desktop";
            "text/x-makefile" = "nvim.desktop";
            "text/x-markdown" = "nvim.desktop";
            "text/markdown" = "nvim.desktop";
            "text/x-tex" = "nvim.desktop";
            "text/x-log" = "nvim.desktop";
            "application/x-yaml" = "nvim.desktop";
            "application/json" = "nvim.desktop";
            "application/toml" = "nvim.desktop";
          })

          (lib.mkIf config.machine.onlyoffice.enable {
            "application/pdf" = "onlyoffice-desktopeditors.desktop";
          })

          {
            "image/jpeg" = "org.gnome.eog.desktop";
            "image/png" = "org.gnome.eog.desktop";
            "image/gif" = "org.gnome.eog.desktop";
            "image/webp" = "org.gnome.eog.desktop";
            "image/svg+xml" = "org.gnome.eog.desktop";
          
            "video/mp4" = "clapper.desktop";
            "video/x-matroska" = "clapper.desktop";
            "video/webm" = "clapper.desktop";
            "video/mpeg" = "clapper.desktop";
            "video/x-msvideo" = "clapper.desktop";
            "audio/mpeg" = "clapper.desktop";
            "audio/mp4" = "clapper.desktop";
            "audio/flac" = "clapper.desktop";
            "audio/ogg" = "clapper.desktop";
            "audio/x-wav" = "clapper.desktop";
          }
        ];
      };
    };
  };
}