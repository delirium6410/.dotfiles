{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.shell.starship;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.shell.starship = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = { lib, config, ... }: {
      stylix.targets.starship.enable = false;
      programs.starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          format = lib.concatStrings [
            "[](color_orange)"
            "$os"
            "$username"
            "[](bg:color_yellow fg:color_orange)"
            "$directory"
            "[](fg:color_yellow bg:color_aqua)"
            "$git_branch"
            "$git_status"
            "[](fg:color_aqua bg:color_blue)"
            "$c"
            "$cpp"
            "$rust"
            "$golang"
            "$nodejs"
            "$php"
            "$java"
            "$kotlin"
            "$haskell"
            "$python"
            "[](fg:color_blue bg:color_bg3)"
            "$docker_context"
            "$conda"
            "$pixi"
            "[](fg:color_bg3 bg:color_bg1)"
            "$time"
            "[ ](fg:color_bg1)"
            "$line_break$character"          
          ];
          
          palette = "stylix";
          palettes.stylix = {
            color_fg_dark = "#${config.lib.stylix.colors.base00}";
            color_fg0 = "#${config.lib.stylix.colors.base05}";
            color_bg1 = "#${config.lib.stylix.colors.base01}";
            color_bg3 = "#${config.lib.stylix.colors.base03}";
            color_blue = "#${config.lib.stylix.colors.base0D}";
            color_aqua = "#${config.lib.stylix.colors.base0C}";
            color_green = "#${config.lib.stylix.colors.base0B}";
            color_orange = "#${config.lib.stylix.colors.base09}";
            color_purple = "#${config.lib.stylix.colors.base0E}";
            color_red = "#${config.lib.stylix.colors.base08}";
            color_yellow = "#${config.lib.stylix.colors.base0A}";
          };

          os = {
            disabled = false;
            style = "bg:color_orange fg:color_fg_dark";
            symbols = {
              Windows = "󰍲";
              Macos = "󰀵";
              NixOS = "";
              Linux = "󰌽";
              Android = "";
            };
          };

          username = {
            show_always = true;
            style_user = "bg:color_orange fg:color_bg1";
            style_root = "bg:color_orange fg:color_bg1";
            format = "[ $user ]($style)";
          };

          directory = {
            style = "fg:color_bg1 bg:color_yellow";
            format = "[ $path ]($style)";
            truncation_length = 3;
            truncation_symbol = "…/";
            substitutions = {
              Documents = "󰈙 ";
              Downloads = " ";
              Music = "󰝚 ";
              Pictures = " ";
              Developer = "󰲋 ";
            };
          };

          git_branch = {
            symbol = "";
            style = "bg:color_aqua";
            format = "[[ $symbol $branch ](fg:color_bg1 bg:color_aqua)]($style)";
          };

          git_status = {
            style = "bg:color_aqua";
            format = "[[($all_status$ahead_behind )](fg:color_bg1 bg:color_aqua)]($style)";
          };

          nodejs = {
            symbol = "";
            style = "bg:color_blue";
            format = "[[ $symbol( $version) ](fg:color_bg1 bg:color_blue)]($style)";
          };

          c = {
            symbol = " ";
            style = "bg:color_blue";
            format = "[[ $symbol( $version) ](fg:color_bg1 bg:color_blue)]($style)";
          };

          cpp = {
            symbol = " ";
            style = "bg:color_blue";
            format = "[[ $symbol( $version) ](fg:color_bg1 bg:color_blue)]($style)";
          };

          rust = {
            symbol = "";
            style = "bg:color_blue";
            format = "[[ $symbol( $version) ](fg:color_bg1 bg:color_blue)]($style)";
          };

          golang = {
            symbol = "";
            style = "bg:color_blue";
            format = "[[ $symbol( $version) ](fg:color_bg1 bg:color_blue)]($style)";
          };

          php = {
            symbol = "";
            style = "bg:color_blue";
            format = "[[ $symbol( $version) ](fg:color_bg1 bg:color_blue)]($style)";
          };

          java = {
            symbol = "";
            style = "bg:color_blue";
            format = "[[ $symbol( $version) ](fg:color_bg1 bg:color_blue)]($style)";
          };

          kotlin = {
            symbol = "";
            style = "bg:color_blue";
            format = "[[ $symbol( $version) ](fg:color_bg1 bg:color_blue)]($style)";
          };

          haskell = {
            symbol = "";
            style = "bg:color_blue";
            format = "[[ $symbol( $version) ](fg:color_bg1 bg:color_blue)]($style)";
          };

          python = {
            symbol = "";
            style = "bg:color_blue";
            format = "[[ $symbol( $version) ](fg:color_bg1 bg:color_blue)]($style)";
          };

          docker_context = {
            symbol = "";
            style = "bg:color_bg3";
            format = "[[ $symbol( $context) ](fg:color_blue bg:color_bg3)]($style)";
          };

          conda = {
            style = "bg:color_bg3";
            format = "[[ $symbol( $environment) ](fg:color_blue bg:color_bg3)]($style)";
          };

          pixi = {
            style = "bg:color_bg3";
            format = "[[ $symbol( $version)( $environment) ](fg:color_bg1 bg:color_bg3)]($style)";
          };

          time = {
            disabled = false;
            time_format = "%R";
            style = "bg:color_bg1";
            format = "[[  $time ](fg:color_fg0 bg:color_bg1)]($style)";
          };

          line_break = {
            disabled = false;
          };

          character = {
            disabled = false;
            success_symbol = "[](bold fg:color_green)";
            error_symbol = "[](bold fg:color_red)";
            vimcmd_symbol = "[](bold fg:color_green)";
            vimcmd_replace_one_symbol = "[](bold fg:color_purple)";
            vimcmd_replace_symbol = "[](bold fg:color_purple)";
            vimcmd_visual_symbol = "[](bold fg:color_yellow)";
          };
        };
      };
    };
  };
}