{ pkgs, ... }:

{
  imports = [ ./base.nix ];

  xresources = {
    properties = {
      "Xft.dpi" = 210;
      "Xft.antialias" = true;
      "Xft.rgba" = "rgb";
      "Xft.hinting" = true;
      "Xft.hintstyle" = "hintslight";
    };
  };

  xsession.windowManager.i3 = {
    extraConfig = ''
      # Remap keys
      exec --no-startup-id ~/Config/system-config/thinkpad-x1/keyboard/setup.sh

      # Backlight control keys
      # bindsym XF86MonBrightnessUp exec --no-startup-id xbacklight -inc 5
      # bindsym $mod+b exec --no-startup-id xbacklight -inc 5
      # bindsym XF86MonBrightnessDown exec --no-startup-id xbacklight -dec 5
      # bindsym $mod+n exec --no-startup-id xbacklight -dec 5

      # bindsym XF86AudioRaiseVolume exec --no-startup-id amixer -D pulse sset Master 1%+
      # bindsym XF86AudioLowerVolume exec --no-startup-id amixer -D pulse sset Master 1%-

      # Firefox-specific windows
      for_window [urgent="latest" class="Firefox"] focus
    '';
  };

  programs = {
    i3status = {
      enable = true;
      enableDefault = false;
      general = {
        colors = true;
        color_good = "#6c71c4";
        color_degraded = "#b58900";
        color_bad = "#dc322f";
        color_separator = "#657b83";
        interval = 5;
      };
      modules = {
        ipv6 = {
          position = 1;
        };
        "wireless _first_" = {
          position = 2;
        };
        "battery all" = {
          position = 3;
        };
        load = {
          position = 4;
        };
        memory = {
          position = 5;
        };
        "tztime local" = {
          position = 6;
        };
      };
    };

    firefox = {
      profiles = {
        mryall = {
          settings = {
            "layout.css.devPixelsPerPx" = "1.6";
          };
        };
      };
    };
  };

}
