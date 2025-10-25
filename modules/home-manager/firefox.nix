{ config, lib, pkgs, inputs, firefox-addons, ... }:
{
  options = {
    machine.firefox.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.firefox.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox.override {
        extraPolicies = {
          DisableFeedbackCommands = true;
          DisableFirefoxAccounts = true;
          DisableFirefoxStudies = true;
          DisableCrashReporter = true;
          DisableProfileImport = true;
          DisableTelemetry = true;
          DisablePocket = true;

          AutofillCreditCardEnabled = false;
          AutofillAddressEnabled = false;
          OfferToSaveLoginsDefault = false;
          OfferToSaveLogins = false;
          PasswordManagerEnabled = false;
          SkipTermsOfUse = true;
          TranslateEnabled = false;
          
          DontCheckDefaultBrowser = true;
          HardwareAcceleration = true;
          ManualAppUpdateOnly = true;
          HttpsOnlyMode = "enabled";
          NetworkPrediction = false;
          ExtensionUpdate = true;

          # add glance url todo 
          # Homepage = mkIf (!config.machine.core.laptop.enable) {
          #   URL = "https://duckduckgo.com";
          #   StartPage = "homepage";
          #   Locked = false;
          # };

          FirefoxHome = {
            Search = true;
            TopSites = false;
            SponsoredTopSites = false;
            Highlights = false;
            Pocket = false;
            SponsoredPocket = false;
            Snippets = false;
            Locked = true;
          };

          Permissions = {
            Camera = {
              BlockNewRequests = true;
              Locked = true;
            };
            Microphone = {
              BlockNewRequests = true;
              Locked = true;
            };
            Location = {
              BlockNewRequests = true;
              Locked = true;
            };
            Notifications = {
              BlockNewRequests = true;
              Locked = true;
            };
            Autoplay = {
              Default = "allow-audio-video";
              Locked = true;
            };
          };
          
          Cookies = {
            Behavior = "reject-tracker"; 
            BehaviorPrivateBrowse = "reject-tracker-and-partition-foreign";
            AcceptThirdParty = "never";
            Locked = false;
          };
          
          EnableTrackingProtection = {
            Value = true; 
            Locked = true; 
            Cryptomining = true;
            Fingerprinting = true; 
            EmailTracking = true;
          };

          SanitizeOnShutdown = {
            Cache = true;
            Locked = true;
          };
        };
      };

      profiles.default = {
        settings= {
          "extensions.autoDisableScopes" = 0;
          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;
        };

        extensions.force = true;
        extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
          bitwarden
          ublock-origin
          sponsorblock
          darkreader
          # tridactyl
        ];
      };
    };
    
    wayland.windowManager.hyprland.settings.bind = lib.mkIf config.machine.hyprland.enable [ "$mod, B, exec, firefox" ];

    home.sessionVariables = {
      BROWSER = "firefox";
    }; 
  };
}
