{ pkgs, ... }:

{
  imports = [ ../base.nix ];

  home = {
    packages = with pkgs; [
      anki
      discord
      firefox
      xclip
      xorg.xdpyinfo
      xorg.xmodmap
    ];

    keyboard = { options = [ "ctrl:nocaps" ]; };
  };

  programs = {
    kitty = { settings = { font_size = 10; }; };
    git = {
      userName = "Matthew Ryall";
      userEmail = "matthew@mexico86.co.uk";
      extraConfig = {
        credential = {
          helper = "git-credential-libsecret";
        };
      };
    };
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
  };

  services.syncthing = { enable = true; };

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
    enable = true;
    config = {
      modifier = "Mod4";
      bars = [{
        position = "top";
        colors = {
          background = "#002b36";
          separator = "#657b83";
          statusline = "#fdf6e3";
          focusedWorkspace = {
            background = "#586e75";
            border = "#93a1a1";
            text = "#fdf6e3";
          };
          inactiveWorkspace = {
            background = "#002b36";
            border = "#073642";
            text = "#657b83";
          };
        };
        fonts = [ "FontAwesome 8" "Hack 8" ];
        extraConfig = ''
          separator_symbol 
        '';
      }];
      colors = {
        focused = {
          background = "#002b36";
          border = "#586e75";
          childBorder = "#586e75";
          indicator = "#268bd2";
          text = "#fdf6e3";
        };
      };
      fonts = [ "FontAwesome 8" "Hack 8" ];
      terminal = "${pkgs.kitty}/bin/kitty";
      assigns = {
        "1: term" = [{ class = "^URxvt$"; }];
        "2: emacs" = [{ class = "^Emacs$"; }];
        "3: web" = [{ class = "^Firefox$"; }];
        "6: key" = [{ class = "^KeePassXC$"; }];
        "0: extra" = [{
          class = "^Firefox$";
          window_role = "About";
        }];
      };
    };

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
}
