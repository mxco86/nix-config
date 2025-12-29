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
        unigine-superposition
        digikam
        darktable
        ansible
        audacity
        yubikey-manager
        picard
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

        input "7119:2208:HID_1bcf:08a0_Mouse" {
          accel_profile adaptive
          pointer_accel -1
          natural_scroll disabled
        }

        # output DVI-D-1 transform 270 position 0 0
        # output DP-1 transform 270 position 1200 0

        bindsym XF86AudioMute exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        bindsym XF86AudioRaiseVolume exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+
        bindsym XF86AudioLowerVolume exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-
        bindsym XF86AudioPlay exec --no-startup-id swaymsg "output * dpms on"
      '';
      config = {
        menu = "fuzzel";
        assigns = {
          "1" = [{app_id = "^Alacritty$";}];
          "2" = [{app_id = "^firefox$";}];
          "7" = [{class = "^Slack$";}];
        };
        workspaceOutputAssign = [
          {
            workspace = "1";
            output = "DVI-D-1";
          }
          {
            workspace = "2";
            output = "DVI-D-1";
          }
          {
            workspace = "3";
            output = "DVI-D-1";
          }
          {
            workspace = "4";
            output = "DVI-D-1";
          }
          {
            workspace = "5";
            output = "DVI-D-1";
          }
          {
            workspace = "6";
            output = "DP-1";
          }
          {
            workspace = "7";
            output = "DP-1";
          }
        ];
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
        settings = {
          user = {
            email = "matthew.ryall@digital.justice.gov.uk";
          };
        };
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
                "layout.css.devPixelsPerPx" = "1";
                "browser.uidensity" = 1;
              };
          };
        };
      };
    };
  };
}
