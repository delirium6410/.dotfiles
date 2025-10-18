{ config, pkgs, lib, inputs, ... }:
{
  options = {
    machine.nix.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.nix.enable {
    nixpkgs.config.allowUnfree = true;
    nix = {
      registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
      nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

      daemonCPUSchedPolicy = "idle";
      daemonIOSchedClass = "idle";

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
        persistent = true;
      };

      settings = {
        auto-optimise-store = true;
        connect-timeout = 5;
        fallback = true;
        log-lines = 25;
        max-free = 1000000000;
        min-free = 128000000;
        warn-dirty = false;
        builders-use-substitutes = true;
        max-jobs = "auto";
        keep-going = true;
        http-connections = 64;
        show-trace = true;
        sandbox = true;

        experimental-features = [
          "nix-command"
          "flakes"
        ];
        substituters = [
          "https://cache.nixos.org"
          "https://nix-community.cachix.org"
          "https://nix-gaming.cachix.org"
          "https://ezkea.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
          "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
        ];
        trusted-users = [
          "@wheel"
        ];
      };
    };

    # soon^tm
    #system.autoUpgrade = {
    #  enable = true;
    #  allowReboot = false;
    #  dates = "04:00";
    #  flake = "github:delirium6410/.dotfiles";
    #  flags = [
    #    "--update-input" "nixpkgs"
    #    "--commit-lock-file"
    #  ];
    #};

    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc.lib
        zlib
        fuse3
        icu
        nss
        openssl
        curl
        expat
        libGL
        libxkbcommon
        xorg.libX11
        xorg.libXcursor
        xorg.libXi
        xorg.libXrandr
      ];
    };
  };
}