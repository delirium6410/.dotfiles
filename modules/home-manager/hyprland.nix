{ config, lib, pkgs, ... }:
{
  options = {
    machine.hyprland.enable = lib.mkEnableOption "";
    machine.hyprland.animations.enable = lib.mkEnableOption "" // {
      default = true;
    };
    machine.hyprland.decorations.enable = lib.mkEnableOption "" // {
      default = true;
    };
  };

  config = lib.mkIf config.machine.hyprland.enable {
    machine.mako.enable = true;
    machine.rofi.enable = true;
    
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      settings = {
        monitor = lib.mkDefault ", preferred, auto, 1";
        
        general = {
          "col.active_border" = lib.mkForce "rgba(${config.lib.stylix.colors.base02}ff) rgba(${config.lib.stylix.colors.base02}ff)";
          "col.inactive_border" = lib.mkForce "rgba(${config.lib.stylix.colors.base02}ff)";
          
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          
          no_border_on_floating = false;
          resize_on_border = true;
          extend_border_grab_area = 5;
          hover_icon_on_border = true;
          
          layout = "master";
          allow_tearing = true;
        };

        decoration = lib.mkMerge [
          (lib.mkIf (!config.machine.hyprland.decorations.enable) {
            rounding = 0;
            active_opacity = 1.0;
            inactive_opacity = 1.0;
            fullscreen_opacity = 1.0;
            dim_inactive = false;

            blur = {
              enabled = false;
            };
            
            shadow = {
              enabled = false;
            };
          })
          
          (lib.mkIf config.machine.hyprland.decorations.enable {
            rounding = 0;
            rounding_power = 1.0;
            active_opacity = 1.0;
            inactive_opacity = 1.0;
            fullscreen_opacity = 1.0;
            
            dim_inactive = true;
            dim_strength = 0.2;
            dim_special = 0.2;
            dim_around = 0.3;

            blur = {
              enabled = true;
              size = 3;
              passes = 3;
            };

            shadow = {
              enabled = true;
              range = 2;
              render_power = 3;
              color = lib.mkForce "rgba(${config.lib.stylix.colors.base02}ff)";
            };
          })
        ];

        animations = lib.mkMerge [
          (lib.mkIf (!config.machine.hyprland.animations.enable) {
            enabled = false;
          })
          (lib.mkIf config.machine.hyprland.animations.enable {
            enabled = true;
            bezier = [
              "easeOutQuint, 0.23, 1, 0.32, 1"
              "easeInOutCubic, 0.65, 0.05, 0.36, 1"
              "linear, 0, 0, 1, 1"
              "almostLinear, 0.5, 0.5, 0.75, 1.0"
              "quick, 0.15, 0, 0.1, 1"
            ];          
            animation = [
              "global, 1, 10, default"
              "border, 1, 5.39, easeOutQuint"
              "windows, 1, 4.79, easeOutQuint"
              "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
              "windowsOut, 1, 1.49, linear, popin 87%"
              "fadeIn, 1, 1.73, almostLinear"
              "fadeOut, 1, 1.46, almostLinear"
              "fade, 1, 3.03, quick"
              "layers, 1, 3.81, easeOutQuint"
              "layersIn, 1, 4, easeOutQuint, fade"
              "layersOut, 1, 1.5, linear, fade"
              "fadeLayersIn, 1, 1.79, almostLinear"
              "fadeLayersOut, 1, 1.39, almostLinear"
              "workspaces, 0, 0, ease"
            ];
          })
        ];

        input = {
          kb_layout = "de";
          kb_options = "altwin:swap_alt_win";
          repeat_rate = 30;
          repeat_delay = 400;
          
          sensitivity = 1.0;
          follow_mouse = 1;

          touchpad = {
            natural_scroll = true;
            disable_while_typing = true;
          };

          accel_profile = "flat";
          numlock_by_default = true;
        };
        
        gestures = {
          workspace_swipe = true;
        };

        master = {
          new_status = "slave";
          orientation = "left";
          new_on_top = false;
          mfact = 0.55;
        };

        "$mod" = "SUPER";
        
        bind = [
          "$mod, Q, killactive,"
          "$mod, ENTER, fullscreen,"
          "$mod, W, togglefloating,"

          "$mod, T, exec, ghostty"          
          "$mod, E, exec, dolphin"
          "$mod, O, exec, obsidian --disable-gpu"

          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
                    
          "$mod, S, togglespecialworkspace"
          "$mod SHIFT, S, movetoworkspace, special"
          
          "$mod, TAB, layoutmsg, cyclenext"
          "$mod SHIFT, TAB, layoutmsg, swapwithmaster"
        ];
        
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
        
        windowrulev2 = [
          "suppressevent maximize, class:.*"
          
          "opacity 0.0 override, class:^(xwaylandvideobridge)$"
          "noanim, class:^(xwaylandvideobridge)$"
          "nofocus, class:^(xwaylandvideobridge)$"
          "noinitialfocus, class:^(xwaylandvideobridge)$"
        ];

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          middle_click_paste = false;
          focus_on_activate = true;
          anr_missed_pings = 3;
          vfr = true;
          vrr = 2;
        };
        
        ecosystem = { 
          no_update_news = true;
          no_donation_nag = true;
        };
        
        autogenerated = 0;
      };
    };    
  };
}