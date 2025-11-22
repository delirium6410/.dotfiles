{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkDefault mkOption types;
  username = config.modules.users.primaryUser.username;
in
{
  options.modules.users.primaryUser = {
    username = mkOption {
      type = types.str;
      default = "admin";
    };
  };

  config = {
    users.users.${username} = {
      isNormalUser = true;
      initialHashedPassword = "$6$r0yqsPZIvinA.V27$5PRURPAT/relNymk63H9DOond9EIEZxxAkLOswe1P4zL5koLN/95Dd0kULldQK7qP17h.LAh9YDBHNc1A1IGk0";
      home = "/home/${username}";
      extraGroups = [ 
        "wheel" 
        "networkmanager" 
        "audio" 
        "video"
      ];
      shell = pkgs.zsh;
    };

    users.users.root = {
      hashedPassword = "!";
    };

    security.sudo.wheelNeedsPassword = mkDefault true;
  };
}