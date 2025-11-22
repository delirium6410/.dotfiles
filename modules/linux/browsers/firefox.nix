{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.browsers.firefox;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
  browserPolicies = import ./_browser-policies.nix;
  browserExtensions = import ./_browser-extensions.nix { inherit inputs pkgs; };
in
{
  options.modules.browsers.firefox = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.firefox = {
        enable = true;
        policies = browserPolicies.privacyPolicies;
        profiles.default = {
          extensions.force = true;
          extensions.packages = browserExtensions.extensions;
          settings = {
            "extensions.autoDisableScopes" = 0;
            "sidebar.revamp" = true;
            "sidebar.verticalTabs" = true;
            "general.autoScroll" = true;
            "browser.tabs.loadInBackground" = true;
            "browser.tabs.loadDivertedInBackground" = true;
          };
        };
      };

      home.sessionVariables = {
        BROWSER = "firefox";
      };

      xdg.mimeApps.defaultApplications = {
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
      }; 
    };
  };
}