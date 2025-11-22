{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.browsers.zen;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
  browserPolicies = import ./_browser-policies.nix;
  browserExtensions = import ./_browser-extensions.nix { inherit inputs pkgs; };
in
{
  options.modules.browsers.zen = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      imports = [ inputs.zen-browser.homeModules.beta ];
      
      programs.zen-browser = {
        enable = true;
        policies = browserPolicies.privacyPolicies;
        profiles.default = {
          extensions.packages = browserExtensions.extensions;
          settings = {
            "general.autoScroll" = true;
            "zen.workspaces.continue-where-left-off" = true;
            "zen.workspaces.natural-scroll" = true;
            "zen.workspaces.enabled" = true;
            "zen.view.compact.hide-tabbar" = true;
            "zen.view.compact.hide-toolbar" = true;
            "zen.welcome-screen.seen" = true;
            "zen.urlbar.behavior" = "float";
            "zen.sidebar.expanded" = false;
            "browser.tabs.loadInBackground" = true;
            "browser.tabs.loadDivertedInBackground" = true;
          };

          pinsForce = true;
          pins = {
            "MyNixOS" = {
              id = "mynixos-pin-id";
              url = "https://mynixos.com";
              position = 101;
              isEssential = false;
            };
          };

          containersForce = true;
          containers = {
            Personal = {
              color = "purple";
              icon = "fingerprint";
              id = 1;
            };
            Work = {
              color = "orange";
              icon = "briefcase";
              id = 2;
            };
            Nix = {
              color = "blue";
              icon = "chill";
              id = 3;
            };
          };
          
          spacesForce = true;
          spaces = {
            "Personal" = {
              id = "personal-space";
              container = 1;
              position = 1000;
            };
            "Work" = {
              id = "work-space";
              icon = "💼";
              container = 2;
              position = 2000;
            };
            "Nix" = {
              id = "nix-space";
              icon = "❄️";
              container = 3;
              position = 3000;
            };
          };

          search = {
            force = true;
            default = "ddg";
            engines = {
              ddg = {
                urls = [{
                  template = "https://duckduckgo.com/?q={searchTerms}";
                }];
                icon = "https://duckduckgo.com/favicon.ico";
                definedAliases = ["ddg"];
              };
            };
          };
        };
      };
      
      home.sessionVariables = {
        BROWSER = "zen";
      };

      xdg.mimeApps.defaultApplications = {
        "text/html" = "zen-beta.desktop";
        "text/xml" = "zen-beta.desktop";
        "application/xhtml+xml" = "zen-beta.desktop";
        "application/xml" = "zen-beta.desktop";
        "application/rss+xml" = "zen-beta.desktop";
        "application/rdf+xml" = "zen-beta.desktop";
        "x-scheme-handler/http" = "zen-beta.desktop";
        "x-scheme-handler/https" = "zen-beta.desktop";
        "x-scheme-handler/ftp" = "zen-beta.desktop";
        "x-scheme-handler/chrome" = "zen-beta.desktop";
        "x-scheme-handler/about" = "zen-beta.desktop";
        "x-scheme-handler/unknown" = "zen-beta.desktop";
      }; 
    };
  };
}