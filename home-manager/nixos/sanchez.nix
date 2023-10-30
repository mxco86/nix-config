{ pkgs, ... }:

let
  waybar = import ./waybar.nix {
    height = 30;
    modules-right = [
      "network"
      "backlight"
      "memory"
      "cpu"
      "wireplumber"
      "battery"
      "clock"
    ];
  };
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
          dwt enabled
          pointer_accel 0.3
          accel_profile adaptive
          natural_scroll disabled
        }

        output "eDP-1" {
          scale 2
        }

        bindsym XF86AudioMute exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        bindsym XF86AudioRaiseVolume exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+
        bindsym XF86AudioLowerVolume exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-
        bindsym XF86MonBrightnessDown exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s 10%-
        bindsym XF86MonBrightnessUp exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s 10%+
        bindsym XF86Display exec --no-startup-id swaymsg "output * dpms on"
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
        settings = [ waybar ];
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
