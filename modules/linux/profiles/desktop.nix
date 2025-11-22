{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.profiles.desktop;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.profiles.desktop = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    modules = {
      profiles.base.enable = true;
      
      # Browsers
      browsers.zen.enable = true;

      # Communication
      communication.discord.enable = true;
      communication.signal.enable = true;
      communication.thunderbird.enable = true;

      # Development
      development.neovim.enable = true;
      development.git.enable = true;
      development.vscode.enable = true;

      # Media
      media.eog.enable = true;
      media.clapper.enable = true;
      media.spotify.enable = true;

      # Networking
      networking.proton.enable = true;

      # Productivity
      productivity.obsidian.enable = true;
      productivity.onlyoffice.enable = true;
      productivity.zathura.enable = true;

      # Security
      security.bitwarden.enable = true;
      
      # Shell
      shell.starship.enable = true;
      
      # System
      system.pipewire.enable = true;
      system.bluetooth.enable = true;
      system.flatpak.enable = true;
      system.printing.enable = true;
      system.plymouth.enable = true;

      # Theming
      theming.stylix.enable = true;
    };

    boot.kernelPackages = pkgs.linuxPackages_zen;
  };
}