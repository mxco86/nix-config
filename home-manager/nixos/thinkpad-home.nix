{ pkgs, ... }:

let
  i3bar = import ./i3bar.nix { inherit pkgs; size = 8.0; };
in
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
    config = {
      assigns = {
        "1: term" = [{ class = "^kitty$"; }];
        "2: emacs" = [{ class = "^Emacs$"; }];
        "3: web" = [{ class = "^Firefox$"; }];
        "4: slack" = [{ class = "^Slack$"; }];
      };
      bars = [ i3bar ];
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
    '';
  };

  programs = {
    ssh = {
      controlPersist = "yes";
      controlMaster = "auto";
      controlPath = "/tmp/%r@%h:%p";
      serverAliveInterval = 20;
      serverAliveCountMax = 2;

      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/mnt/k/id_rsa.pub";
          identitiesOnly = true;
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

    firefox = {
      profiles = {
        mryall = {
          settings = {
            "layout.css.devPixelsPerPx" = "1.6";
            "font.size.systemFontScale" = 100;
            "browser.uidensity" = 1;
          };
          userChrome = ''
            #TabsToolbar { visibility: collapse !important; }

            #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
                display:none;
            }

            #urlbar { font-size: 14pt !important }
            #statuspanel { font-size: 14pt !important }
            #main-menubar { font-size: 14pt !important }

            menubar, menubutton, menulist, menu, menuitem,
            textbox, findbar, toolbar, tab, tree, tooltip {
              font-size: 14pt !important;
            }

            .tabbrowser-tab {
               min-height: var(--tab-min-height) !important;
               overflow: visible !important;
               font-size: 14pt !important;
               background: 0 !important;
               border: 0 !important;
            }
          '';
        };
      };
    };
  };
}
