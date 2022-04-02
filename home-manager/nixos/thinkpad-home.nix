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
