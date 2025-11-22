{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop.waybar;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.desktop.waybar = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      stylix.targets.waybar.enable = false;
      programs.waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            margin-top = 7;
            margin-left = 7;
            margin-right = 7;
            height = 30;
            spacing = 0;

            modules-left = ["custom/launcher"];
            modules-center = ["hyprland/workspaces"];
            modules-right = ["tray" "network" "pulseaudio" "battery" "clock" "custom/notifications"];

            # Left modules
            "custom/launcher" = {
              format = "󱄅  ";
              tooltip = false;
              on-click = "pkill rofi || rofi -show drun";
            };

            "hyprland/workspaces" = {
              active-only = false;
              all-outputs = true;
              format = "{icon}";
              show-special = false;
              persistent-workspaces = {
                "1" = [];
                "2" = [];
                "3" = [];
                "4" = [];
                "5" = [];
              };
              format-icons = {
                "1" = "";
                "2" = "";
                "3" = "";
                "4" = "";
                "5" = "";
                default = "";
                active = "󱓻";
                urgent = "󱓻";
              };
            };

            # Center modules

            # Right modules
            tray = {
              spacing = 10;
            };

            network = {
              format-ethernet = "󰈀 ";
              format-wifi = "{icon}";
              format-disconnected = "󰤭 ";
              format-icons = ["󰤯 " "󰤟 " "󰤢 " "󰤥 " "󰤨 "];
              tooltip-format-wifi = "{essid}";
              tooltip-format-ethernet = "IP: {ipaddr}";
              tooltip-format-disconnected = "No Internet Connection";
              nospacing = 1;
            };


            pulseaudio = {
              format = "{icon}";
              nospacing = 1;
              tooltip-format = "Volume : {volume}%";
              format-muted = "󰝟 ";
              format-icons = {
                default = ["󰕿 " "󰖀 " "󰕾 "];
              };
              on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
              on-click-right = "pavucontrol";
              scroll-step = 5;
            };

            battery = {
              states = {
                good = 95;
                warning = 30;
                critical = 15;
              };
              format = "{icon}";
              format-charging = "󰂄";
              format-plugged = "󰚥";
              format-alt = "{time}";
              format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
              tooltip-format = "Battery: {capacity}%\nTime remaining: {time}";
            };

            clock = {
              tooltip-format = "<tt><small>{calendar}</small></tt>";
              format-alt = "  {:%a, %d %b %Y} ";
              format = "{:%H:%M}";
              calendar = {
                weeks-pos = "none";
                on-scroll = 1;
                format = {
                  months = "<span color='#${config.lib.stylix.colors.base0D}'><b>{}</b></span>";
                  days = "<span color='#${config.lib.stylix.colors.base04}'>{}</span>";
                  weeks = "<span color='#${config.lib.stylix.colors.base0C}'><b>W{}</b></span>";
                  weekdays = "<span color='#${config.lib.stylix.colors.base0E}'><b>{}</b></span>";
                  today = "<span color='#${config.lib.stylix.colors.base08}'><b>{}</b></span>";
                };
              };
            };

            "custom/notifications" = {
              format = "󰂚 ";
              tooltip = false;
              on-click = "swaync-client -t";
            };
          };
        };

        style = with config.lib.stylix.colors; ''
          * {
            font-family: "Symbols Nerd Font", "DejaVu Sans";
            font-size: 17px;
            border: none;
            border-radius: 0;
            min-height: 0;
          }

          window#waybar {
            background-color: alpha(#${base00}, 0.9);
            color: #${base05};
            border-radius: 8px;
            border-width: 3px;
            border-color: #${base03};
            border-style: solid;
          }

          window#waybar.hidden {
            opacity: 0.1;
          }


          #workspaces {
            color: #${base0C};
            border-radius: 8px;
          }

          #clock,
          #tray,
          #custom-notifications,
          #battery {
            color: #${base04};
            border-radius: 8px;
            transition: color 0.3s ease-in-out;
          }

          #clock:hover,
          #tray:hover,
          #custom-notifications:hover,
          #battery:hover {
            color: #${base0D};
          }

          @keyframes button_activate {
              from { opacity: .3 }
              to { opacity: 1.; }
          }

          #workspaces button {
              border: none;
              border-bottom: none;
              color: #${base04};
              padding: 3px;
              background: transparent;
              box-shadow: none;
              transition: all 0.3s ease-in-out;
          }


          #workspaces button.urgent {
              color: #${base08};
              background: inherit;
          }

          #workspaces button.empty {
              color: #${base04};
          }

          #workspaces button:hover {
              border: none;
              background: #${base02};
              margin: 1px;
              border-radius: 8px;
          }

          #workspaces button.active {
              color: #${base0D};
              background: alpha(#${base03}, 0.7);
              border-bottom: none;
              padding: 0px 13px;
              margin: 1px;
              border-radius: 8px;
              animation: button_activate 0.3s ease-in-out;
              transition: all 0.3s ease-in-out;
          }

          #workspaces button.active:hover {
              background: #${base02};
          }

          #workspaces button.urgent:hover {
              background: inherit;
          }

          #custom-launcher {
            margin-left: 10px;
            margin-right: 10px;
            padding-right: 5px;
            padding-left: 5px;
            font-size: 22px;
            color: #${base04};
            margin-top: 1px;
            margin-bottom: 1px;
            border-radius: 8px;
            transition: color 0.3s ease-in-out;
          }

          #custom-launcher:hover {
            color: #${base0D};
          }

          #workspaces,
          #clock,
          #pulseaudio,
          #tray,
          #network,
          #battery {
            background-color: #${base01};
            padding: 0em 2em;
            font-size: 20px;
            padding-left: 7.5px;
            padding-right: 7.5px;
            padding-top: 2px;
            padding-bottom: 2px;
            margin-top: 10px;
            margin-bottom: 10px;
            margin-right: 10px;
          }

          #workspaces {
            padding-right: 10px;
          }

          #pulseaudio {
            color: #${base04};
            padding-left: 10px;
            margin-right: 10px;
            font-size: 25px;
            border-radius: 0px 8px 8px 0px;
            margin-left: -5px;
            transition: color 0.3s ease-in-out;
          }

          #pulseaudio:hover {
            color: #${base0D};
          }

          #pulseaudio.muted {
            color: #${base08};
            padding-left: 10px;
            font-size: 25px;
            border-radius: 0px 8px 8px 0px;
          }

          #network {
            padding-left: 0.2em;
            color: #${base04};
            border-radius: 8px 0px 0px 8px;
            padding-left: 12px;
            padding-right: 14px;
            font-size: 20px;
            margin-right: -5px;
            transition: color 0.3s ease-in-out;
          }

          #network:hover {
            color: #${base0D};
          }

          #network.disconnected {
            color: #${base08};
          }


          #clock {
            font-size: 17px;
            font-weight: bold;
            margin-top: 10px;
            margin-right: 10px;
            margin-bottom: 10px;
          }

          #custom-notifications {
            margin-right: 12px;
            padding: 0 6px 0 6.8px;
            margin-top: 7px;
            margin-bottom: 7px;
          }

          #battery {
            padding-left: 8.5px;
            padding-right: 8.5px;
          }

          tooltip {
            border-radius: 8px;
            padding: 15px;
            background-color: #${base00};
            color: #${base05};
          }

          tooltip label {
            padding: 5px;
            background-color: #${base00};
          }

          label:focus {
            background-color: #${base00};
          }

          #tray {
            margin-right: 10px;
            margin-top: 10px;
            margin-bottom: 10px;
            font-size: 30px;
          }

          #tray > .passive {
            -gtk-icon-effect: dim;
          }

          #tray > .needs-attention {
            -gtk-icon-effect: highlight;
            background-color: #${base08};
          }
        '';
      };
    };
  };
}