{ pkgs, ... }:

{
  imports = [ ../base.nix ];

  home = {
    packages = with pkgs; [
      # anki
      discord
      firefox
      keepassxc
      slack
      nix-linter
      xclip
      xorg.xdpyinfo
      xorg.xmodmap
      zoom-us
      jetbrains.idea-community
    ];

    keyboard = { options = [ "ctrl:nocaps" ]; };
  };

  programs.kitty = {
    settings = {
      # Fonts
      font_size = 10;
    };
  };

  programs.urxvt = {
    enable = true;
    fonts = [ "xft:Hack:size=10" "xft:Noto Color Emoji:size=10" ];
    scroll = {
      lines = 50;
      bar = {
        enable = false;
        style = "rxvt";
      };
    };
    extraConfig = {
      "depth" = 32;
      "transparent" = false;
      "fading" = 0;
      "loginShell" = true;
      "internalBorder" = 3;
      "lineSpace" = 0;
      "print-pipe" = "cat > /dev/null";

      # Fonts
      "boldfont" =
        [ "xft:Hack-Bold:size=10" "xft:Noto Color Emoji One:size=10" ];
      "*letterSpace" = -1;

      # Solarized colour scheme
      "intensityStyles" = false;
      "background" = "#002b36";
      "foreground" = "#657b83";
      "fadeColor" = "#002b36";
      "cursorColor" = "#93a1a1";
      "pointerColorBackground" = "#586e75";
      "pointerColorForeground" = "#93a1a1";

      # black dark/light
      "color0" = "#073642";
      "color8" = "#002b36";

      # red dark/light
      "color1" = "#dc322f";
      "color9" = "#cb4b16";

      # green dark/light
      "color2" = "#859900";
      "color10" = "#586e75";

      # yellow dark/light
      "color3" = "#b58900";
      "color11" = "#657b83";

      # blue dark/light
      "color4" = "#268bd2";
      "color12" = "#839496";

      # magenta dark/light
      "color5" = "#d33682";
      "color13" = "#6c71c4";

      # cyan dark/light
      "color6" = "#2aa198";
      "color14" = "#93a1a1";

      # white dark/light
      "color7" = "#eee8d5";
      "color15" = "#fdf6e3";
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
      bars = [{ position = "top"; }];
      fonts = [ "FontAwesome 10" "pango:DejaVu Sans Mono 8" ];
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
