{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop.rofi;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.desktop.rofi = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      stylix.targets.rofi.enable = false;
      
      programs.rofi = {
        enable = true;
        package = pkgs.rofi;      
        terminal = "ghostty";
        extraConfig = {
          modi = "drun";
          show-icons = true;
          display-drun = "drun :";
          drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
        };
        theme = "./theme.rasi";
      };

      xdg.configFile."rofi/theme.rasi".text = with config.lib.stylix.colors; ''
        /**
         * Rofi Theme with Stylix Integration
         * Based on adi1090x theme
         */

        /*****----- Configuration -----*****/
        configuration {
            modi:                       "drun";
            show-icons:                 true;
            display-drun:               "drun :";
            display-run:                "";
            display-filebrowser:        "";
            display-window:             "";
            drun-display-format:        "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
            window-format:              "{w} · {c} · {t}";
        }

        /*****----- Global Properties -----*****/
        * {
            background:                  #${base00};
            background-alt:              #${base01};
            foreground:                  #${base05};
            selected:                    #${base0D};
            active:                      #${base0B};
            urgent:                      #${base08};
            
            border-colour:               var(selected);
            handle-colour:               var(selected);
            background-colour:           var(background);
            foreground-colour:           var(foreground);
            alternate-background:        var(background-alt);
            normal-background:           var(background);
            normal-foreground:           var(foreground);
            urgent-background:           var(urgent);
            urgent-foreground:           var(background);
            active-background:           var(active);
            active-foreground:           var(background);
            selected-normal-background:  var(selected);
            selected-normal-foreground:  var(background);
            selected-urgent-background:  var(active);
            selected-urgent-foreground:  var(background);
            selected-active-background:  var(urgent);
            selected-active-foreground:  var(background);
            alternate-normal-background: var(background);
            alternate-normal-foreground: var(foreground);
            alternate-urgent-background: var(urgent);
            alternate-urgent-foreground: var(background);
            alternate-active-background: var(active);
            alternate-active-foreground: var(background);
            
            font:                        "DejaVu Sans 12";
        }

        /*****----- Main Window -----*****/
        window {
            transparency:                "real";
            location:                    center;
            anchor:                      center;
            fullscreen:                  false;
            width:                       600px;
            height:                      700px;
            x-offset:                    0px;
            y-offset:                    0px;

            enabled:                     true;
            margin:                      0px;
            padding:                     20px;
            border:                      2px solid;
            border-radius:               20px;
            border-color:                #${base05};
            cursor:                      "default";
            background-color:            @background-colour;
        }

        /*****----- Main Box -----*****/
        mainbox {
            enabled:                     true;
            spacing:                     20px;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                @border-colour;
            background-color:            transparent;
            children:                    [ "inputbar", "listview" ];
        }

        /*****----- Inputbar -----*****/
        inputbar {
            enabled:                     true;
            spacing:                     10px;
            margin:                      0px;
            padding:                     20px;
            border:                      0px;
            border-radius:               20px;
            border-color:                @border-colour;
            background-color:            @alternate-background;
            text-color:                  @foreground-colour;
            children:                    [ "entry" ];
        }

        entry {
            enabled:                     true;
            background-color:            transparent;
            text-color:                  inherit;
            cursor:                      text;
            placeholder:                 "Type here to search for apps";
            placeholder-color:           inherit;
            vertical-align:              0.5;
            horizontal-align:            0.5;
        }

        /*****----- Listview -----*****/
        listview {
            enabled:                     true;
            columns:                     1;
            lines:                       12;
            cycle:                       true;
            dynamic:                     true;
            scrollbar:                   false;
            layout:                      vertical;
            reverse:                     false;
            fixed-height:                true;
            fixed-columns:               true;
            
            spacing:                     10px;
            margin:                      0px;
            padding:                     30px;
            border:                      0px solid;
            border-radius:               20px;
            border-color:                @border-colour;
            background-color:            @alternate-background;
            text-color:                  @foreground-colour;
            cursor:                      "default";
        }

        /*****----- Elements -----*****/
        element {
            enabled:                     true;
            spacing:                     10px;
            margin:                      0px;
            padding:                     8px;
            border:                      0px solid;
            border-radius:               12px;
            border-color:                @border-colour;
            background-color:            transparent;
            text-color:                  @foreground-colour;
            cursor:                      pointer;
        }

        element normal.normal {
            background-color:            transparent;
            text-color:                  var(normal-foreground);
        }

        element selected.normal {
            background-color:            #${base02};
            text-color:                  var(foreground-colour);
        }

        element-icon {
            background-color:            transparent;
            text-color:                  inherit;
            size:                        32px;
            cursor:                      inherit;
        }

        element-text {
            background-color:            transparent;
            text-color:                  inherit;
            highlight:                   inherit;
            cursor:                      inherit;
            vertical-align:              0.5;
            horizontal-align:            0.0;
        }
      '';
    };
  };
}