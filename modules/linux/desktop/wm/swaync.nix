{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop.swaync;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.desktop.swaync = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [
        libnotify
        networkmanagerapplet
        overskride
        playerctl
        ddcutil
        brightnessctl
        pwvucontrol
        gnome-calculator
      ];

      services.swaync = {
        enable = true;
        settings = {
          positionX = "right";
          positionY = "top";
          layer = "overlay";
          control-center-layer = "top";
          layer-shell = true;
          cssPriority = "application";
          control-center-margin-top = 10;
          control-center-margin-bottom = 10;
          control-center-margin-right = 10;
          control-center-margin-left = 0;
          notification-2fa-command = true;
          notification-inline-replies = false;
          notification-icon-size = 64;
          notification-body-image-height = 100;
          notification-body-image-width = 200;
          timeout = 10;
          timeout-low = 5;
          timeout-critical = 0;
          fit-to-screen = true;
          relative-timestamps = true;
          control-center-width = 500;
          control-center-height = 600;
          notification-window-width = 500;
          keyboard-shortcuts = true;
          image-visibility = "when-available";
          transition-time = 200;
          hide-on-clear = false;
          hide-on-action = true;
          script-fail-notify = true;

          widgets = [
            "title"
            "dnd"
            "buttons-grid"
            "backlight"
            "volume"
            "mpris"
            "notifications"
          ];

          widget-config = {
            title = {
              text = "Notifications";
              clear-all-button = true;
              button-text = " 󰎟 ";
            };
            dnd = {
              text = "Do not disturb";
            };
            volume = {
              label = "󰕾 ";
              show-per-app = false;
              min = 1;
            };
            backlight = {
              label = "󰃟 ";
              min = 1;
            };
            mpris = {
              image-size = 96;
              image-radius = 12;
            };
            buttons-grid = {
              actions = [
                {
                  label = "󰤨";
                  command = "nm-connection-editor";
                }
                {
                  label = "󰂯";
                  command = "overskride";
                }
                {
                  label = "󰕾";
                  command = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
                  type = "toggle";
                }
                {
                  label = "󰍬";
                  command = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
                  type = "toggle";
                }
                {
                  label = "󰖔";
                  command = "pkill gammastep || gammastep -P -O 3000";
                  type = "toggle";
                }
                {
                  label = "󰀝";
                  command = "rfkill toggle all";
                  type = "toggle";
                }
                {
                  label = "󰌆";
                  command = "protonvpn-app";
                }
                {
                  label = "󰃬";
                  command = "gnome-calculator";
                }
                {
                  label = "󰹑";
                  command = "swaync-client -cp && sleep 0.5 && grim - | swappy -f -";
                }
                {
                  label = "󰐥";
                  command = "wlogout";
                }
              ];
            };
          };
        };

        style = with config.lib.stylix.colors; ''
          * {
            color: #${base05};
            all: unset;
            font-family: "Symbols Nerd Font", "DejaVu Sans";
            font-size: 16px;
            font-weight: bold;
            transition: background 200ms, border-color 200ms;
          }

          .blank-window {
            background: transparent;
          }

          .control-center {
            background: #${base00};
            border-radius: 24px;
            border: 1px solid #${base03};
            box-shadow: 0 0 10px 0 rgba(0,0,0,.6);
            margin: 18px;
            padding: 12px;
          }

          .widget-label {
            margin: 6px 6px 6px 140px;
            color: #${base0C};
          }

          .widget-title {
            color: #${base05};
            font-size: 1.2em;
            margin: 6px;
          }

          .widget-title button {
            background: #${base01};
            border-radius: 6px;
            padding: 4px 16px;
            border: 1px solid #${base03};
          }

          .widget-title button:hover {
            background-color: #${base04};
            color: #${base01};
            border-color: #${base04};
            transition: none;
          }

          .widget-dnd {
            color: #${base05};
            margin: 6px;
            font-size: 1.2rem;
          }

          .widget-dnd > switch {
            background: #${base01};
            border-radius: 8px;
            padding: 2px;
            border: 1px solid #${base03};
          }

          .widget-dnd > switch:checked {
            background: alpha(#${base0C}, .7);
            border-color: #${base03};
          }

          .widget-dnd > switch slider {
            background: #${base05};
            border-radius: 6px;
          }

          .widget-buttons-grid {
            font-size: x-large;
            padding: 6px;
            margin: 6px;
            border-radius: 12px;
            background: #${base01};
            color: #${base05};
            border: 1px solid #${base03};
          }

          .widget-buttons-grid > flowbox > flowboxchild > button {
            margin: 4px;
            padding: 6px;
            background: transparent;
            border-radius: 8px;
            min-width: 60px;
            border: 1px solid #${base03};
          }

          .widget-buttons-grid > flowbox > flowboxchild > button:hover {
            background: #${base04};
            color: #${base01};
            border-color: #${base02};
            transition: none;
          }

          .widget-buttons-grid > flowbox > flowboxchild > button.toggle:checked {
            background: #${base03};
            color: #${base01};
            transition: none;
          }

          .widget-mpris {
            background: alpha(#${base04}, .2);
            border-radius: 16px;
            padding: 6px;
            margin: 20px 6px;
          }

          .widget-mpris-player {
            background: #${base0C};
            padding: 6px 10px;
            margin: 10px;
            border-radius: 14px;
          }

          .widget-mpris-album-art {
            border-radius: 16px;
          }

          .widget-volume, .widget-backlight {
            background: transparent;
            color: #${base05};
            padding: 4px;
            margin: 6px;
            border-radius: 6px;
          }


          progressbar, progress, trough {
            border-radius: 20px;
            background: transparent;
          }

          trough highlight {
            padding: 4px;
            background: #${base05};
            border-radius: 20px;
            box-shadow: 0px 0px 5px rgba(0, 0, 0, .5);
          }

          trough slider {
            background: transparent;
            min-height: 6px;
            min-width: 14px;
          }

          trough slider:hover {
            background: transparent;
          }

          trough highlight:hover {
            background: #${base05};
            box-shadow: 0px 0px 5px rgba(0, 0, 0, .5);
          }

          .control-center .notification-row .notification-background,
          .control-center .notification-row .notification-background .notification.critical {
            border-radius: 16px;
            margin: 2px;
            padding: 6px;
            border: 1px solid #${base03};
          }

          .control-center .notification-row .notification-background .notification.critical {
            color: #${base08};
          }

          .control-center .notification-row .notification-background .notification {
            border-radius: 12px;
            margin: 2px;
            padding: 8px;
          }

          .control-center .notification-row .notification-background .notification .notification-content {
            margin: 6px;
            padding: 8px 6px 2px 2px;
          }

          .control-center .notification-row .notification-background .notification > *:last-child > * {
            min-height: 3.4em;
          }

          .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action {
            background: #${base03};
            color: #${base05};
            border-radius: 12px;
            margin: 6px;
          }

          .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
            background: #${base04};
          }

          .control-center .notification-row .notification-background .close-button {
            background: transparent;
            border-radius: 6px;
            color: #${base05};
            margin: 0px;
            padding: 4px;
          }

          .control-center .notification-row .notification-background .close-button:hover {
            background-color: #${base04};
            color: #${base01};
            transition: none;
          }

          .notification {
            border-radius: 12px;
          }

          .notification-window .notification-row .notification-background {
            border-radius: 16px;
            margin: 4px 0px;
            padding: 4px;
            border: 1px solid #${base03};
          }

          .notification-window .notification {
            border-radius: 12px;
          }

          .notification-content {
            border-radius: 12px;
          }

          .notification-default-action {
            border-radius: 12px;
          }
        '';
      };
    };
  };
}