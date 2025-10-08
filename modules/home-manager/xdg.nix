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
        defaultApplications = {
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

          "image/jpeg" = "eog.desktop";
          "image/png" = "eog.desktop";
          "image/gif" = "eog.desktop";
          "image/webp" = "eog.desktop";
          "image/svg+xml" = "eog.desktop";
          
          "video/mp4" = "mpv.desktop";
          "video/x-matroska" = "mpv.desktop";
          "video/webm" = "mpv.desktop";
          "video/mpeg" = "mpv.desktop";
          "video/x-msvideo" = "mpv.desktop";

          "audio/mpeg" = "mpv.desktop";
          "audio/mp4" = "mpv.desktop";
          "audio/flac" = "mpv.desktop";
          "audio/ogg" = "mpv.desktop";
          "audio/x-wav" = "mpv.desktop";

          "application/pdf" = "onlyoffice-desktopeditors.desktop";
        };
      };
    };
    
    home.sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERMINAL = "ghostty";
    };
  };
}
