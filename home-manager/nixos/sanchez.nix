{ pkgs, ... }:

let
  waybar = import ./waybar.nix;
in
{
  imports = [ ./base.nix ];

  home-manager.users.mryall = { pkgs, ... }: {

    wayland.windowManager.sway = {
      extraConfig = ''
        input "type:keyboard" {
          xkb_options ctrl:nocaps,altwin:prtsc_rwin
        }

        input "type:touchpad" {
          middle_emulation disabled
          click_method clickfinger
        }

        output "eDP-1" {
          scale 2
        }
      '';
      config = {
        # menu = "rofi -modi drun -show drun -theme solarized -font 'Iosevka 14'";
        menu = "wofi";
        assigns = {
          "1" = [{ class = "^Alacritty$"; }];
          "2" = [{ class = "^Emacs$"; }];
          "3" = [{ class = "^firefox$"; }];
          "4" = [{ class = "^Slack$"; }];
        };
        bars = [ ];
        startup = [
          # { command = "librewolf"; }
          # { command = "signal-desktop"; }
          # { command = "mako"; }
        ];
        fonts = {
          size = 10.0;
        };
      };
      # extraConfig = ''
      #   # Remap keys
      #   exec --no-startup-id ~/Config/system-config/thinkpad-x1/keyboard/setup.sh

      #   # Backlight control keys
      #   # bindsym XF86MonBrightnessUp exec --no-startup-id xbacklight -inc 5
      #   # bindsym $mod+b exec --no-startup-id xbacklight -inc 5
      #   # bindsym XF86MonBrightnessDown exec --no-startup-id xbacklight -dec 5
      #   # bindsym $mod+n exec --no-startup-id xbacklight -dec 5

      #   # bindsym XF86AudioRaiseVolume exec --no-startup-id amixer -D pulse sset Master 1%+
      #   # bindsym XF86AudioLowerVolume exec --no-startup-id amixer -D pulse sset Master 1%-
      # '';
    };

    programs = {
      alacritty = {
        settings = {
          font = {
            size = 12;
          };
        };
      };
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

      waybar = {
        enable = true;
        systemd.enable = true;
        settings = [ waybar ];

        style = ''
          ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}

          * {
               border: none;
               border-radius: 0;
               font-family: "Iosevka, FontAwesome";
               font-size: 14px;
               min-height: 0;
          }

          window#waybar {
            background: transparent;
            background-color: #002b36;
            border-bottom: none;
            color: #fdf6e3;
          }

          #network, #backlight, #cpu, #memory, #temperature, #battery, #pulseaudio, #clock {
            background-color: #002b36;
            color: #fdf6e3;
          }
        '';
      };

      firefox = {
        profiles = {
          mryall = {
            settings = {
              "layout.css.devPixelsPerPx" = "1.5";
              "browser.uidensity" = 1;
            };
            userChrome = ''
              #TabsToolbar { visibility: collapse !important; }
            '';
          };
        };
      };
      git = {
        userName = "Matthew Ryall";
        userEmail = "matthew@mexico86.co.uk";
        signing = { key = "0902EF0CB4879CEB"; signByDefault = true; };
      };
    };
  };
}
