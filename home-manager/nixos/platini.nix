{pkgs, ...}: let
  waybar = import ./waybar.nix {
    height = 40;
    modules-right = [
      "network"
      "memory"
      "cpu"
      "disk"
      "wireplumber"
      "clock"
    ];
  };

  firefoxCfg = import ../firefox.nix {};
in {
  imports = [./base.nix];

  home-manager.users.mryall = {...}: {
    home = {
      packages = with pkgs; [
      ];
    };

    wayland.windowManager.sway = {
      extraConfig = ''
        input "type:keyboard" {
          xkb_options ctrl:nocaps
        }

        input "type:touchpad" {
          middle_emulation disabled
          click_method clickfinger
          dwt enabled
          pointer_accel 0.3
          accel_profile adaptive
          natural_scroll disabled
        }

        output eDP-1 mode 1920x1080

        bindsym XF86AudioMute exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        bindsym XF86AudioRaiseVolume exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+
        bindsym XF86AudioLowerVolume exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-
        bindsym XF86AudioPlay exec --no-startup-id swaymsg "output * dpms on"
      '';

      config = {
        menu = "fuzzel";
        bars = [];
        fonts = {
          size = 14.0;
        };
      };
    };

    programs = {
      alacritty = {
        settings = {
          font = {
            size = 14;
          };
        };
      };

      waybar = {
        settings = [waybar];
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
            identityFile = "~/mnt/k/id_rsa";
            identitiesOnly = true;
          };
        };
      };

      git = {
        userName = "Matthew Ryall";
        userEmail = "matthew.ryall@digital.justice.gov.uk";
        signing = {
          key = "0902EF0CB4879CEB";
          signByDefault = true;
        };
      };

      firefox = {
        profiles = {
          mryall = {
            settings =
              firefoxCfg.settings
              // {
                "layout.css.devPixelsPerPx" = "2";
                "browser.uidensity" = 1.2;
              };
          };
        };
      };
    };
  };
}
