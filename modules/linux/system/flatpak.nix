{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.modules.system.flatpak;
  inherit (lib) mkEnableOption mkIf;
in
{
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  options.modules.system.flatpak = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    services.flatpak = {
      enable = true;    
      update.auto = {
        enable = true;
        onCalendar = "weekly";
      };

      remotes = [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
      ];

      overrides = {
        global = {
          Context = {
            sockets = [ "wayland" "!x11" "!fallback-x11" ];
            filesystems = [ 
              "!host" 
              "xdg-config/gtk-3.0:ro"
              "xdg-config/gtk-4.0:ro"
              "~/.themes:ro"
              "~/.icons:ro"
            ];
          };
          Environment = {
            # Enable proper theme detection
            XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
          };
        };
      };
    };
  };
}