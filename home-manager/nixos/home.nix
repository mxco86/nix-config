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

  programs = {
    kitty = { settings = { font_size = 10; }; };
    ssh = {
      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/mnt/k/id_rsa";
          identitiesOnly = true;
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
        colors = { background = "#002b36"; };
      }];
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
