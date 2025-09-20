{ config, pkgs, lib, ... }:
{
  options = {
    system.nix-ld.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.system.nix-ld.enable {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
        openssl
        curl
        glib
      ];
    };
  };
}