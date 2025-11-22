{
  # check again for options truly necessary or unsupported by zen/that are defaults in zen
  privacyPolicies = {
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
    
    # for adnauseam to work properly
    # EnableTrackingProtection = {
    #   Value = true; 
    #   Locked = true; 
    #   Cryptomining = true;
    #   Fingerprinting = true; 
    #   EmailTracking = true;
    # };

    SanitizeOnShutdown = {
      Cache = true;
      Locked = true;
    };
  };
}