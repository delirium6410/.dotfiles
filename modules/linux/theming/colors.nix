{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.theming.colors;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.theming.colors = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = { config, ... }: {
      xdg.configFile."stylix/colors.css".text = with config.lib.stylix.colors; ''
        :root { 
          /* Base colors */
          --base00: #${base00}; /* Default Background */
          --base01: #${base01}; /* Lighter Background */
          --base02: #${base02}; /* Selection Background */
          --base03: #${base03}; /* Comments, Invisibles */
          --base04: #${base04}; /* Dark Foreground */
          --base05: #${base05}; /* Default Foreground */
          --base06: #${base06}; /* Light Foreground */
          --base07: #${base07}; /* Light Background */

          /* Accent colors */
          --base08: #${base08}; /* Red */
          --base09: #${base09}; /* Orange */
          --base0A: #${base0A}; /* Yellow */
          --base0B: #${base0B}; /* Green */
          --base0C: #${base0C}; /* Aqua */
          --base0D: #${base0D}; /* Blue */
          --base0E: #${base0E}; /* Purple */
          --base0F: #${base0F}; /* Brown */

          /* Color mappings */
          --background: var(--base00);
          --background-alt: var(--base01);
          --foreground: var(--base05);
          --foreground-alt: var(--base04);
          --accent: var(--base0D);
          --urgent: var(--base08);
          --warning: var(--base0A);
          --success: var(--base0B);
        }
      '';
    };
  };
}