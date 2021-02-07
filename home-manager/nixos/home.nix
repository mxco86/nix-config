{ pkgs, ... }:

{
  imports = [ ../base.nix ];

  home = {
    packages = with pkgs; [
      anki
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
      "URxvt.depth" = 32;
      "URxvt.transparent" = false;
      "URxvt.fading" = 0;
      "URxvt.loginShell" = true;
      "URxvt.internalBorder" = 3;
      "URxvt.lineSpace" = 0;
      "URxvt.print-pipe" = "cat > /dev/null";

      # Fonts
      "URxvt.boldfont" =
        [ "xft:Hack-Bold:size=10" "xft:Noto Color Emoji One:size=10" ];
      "URxvt*letterSpace" = -1;

      # Solarized colour scheme
      "URxvt.intensityStyles" = false;
      "URxvt.background" = "#002b36";
      "URxvt.foreground" = "#657b83";
      "URxvt.fadeColor" = "#002b36";
      "URxvt.cursorColor" = "#93a1a1";
      "URxvt.pointerColorBackground" = "#586e75";
      "URxvt.pointerColorForeground" = "#93a1a1";

      # black dark/light
      "URxvt.color0" = "#073642";
      "URxvt.color8" = "#002b36";

      # red dark/light
      "URxvt.color1" = "#dc322f";
      "URxvt.color9" = "#cb4b16";

      # green dark/light
      "URxvt.color2" = "#859900";
      "URxvt.color10" = "#586e75";

      # yellow dark/light
      "URxvt.color3" = "#b58900";
      "URxvt.color11" = "#657b83";

      # blue dark/light
      "URxvt.color4" = "#268bd2";
      "URxvt.color12" = "#839496";

      # magenta dark/light
      "URxvt.color5" = "#d33682";
      "URxvt.color13" = "#6c71c4";

      # cyan dark/light
      "URxvt.color6" = "#2aa198";
      "URxvt.color14" = "#93a1a1";

      # white dark/light
      "URxvt.color7" = "#eee8d5";
      "URxvt.color15" = "#fdf6e3";
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
