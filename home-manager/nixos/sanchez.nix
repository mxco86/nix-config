{
  pkgs,
  nur,
  inputs,
  ...
}: let
  waybar = import ./waybar.nix {
    height = 30;
    modules-right = [
      "network"
      "backlight"
      "memory"
      "cpu"
      "disk"
      "wireplumber"
      "battery"
      "clock"
    ];
  };

  firefoxCfg = import ../firefox.nix {};
in {
  imports = [./base.nix];

  home-manager.extraSpecialArgs = {inherit inputs;};

  home-manager.users.mryall = {...}: {
    imports = [inputs.glide.homeModules.default];

    home.packages = with pkgs; [
      picard
      czkawka
      yubikey-manager
      jai-jail
    ];

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
        menu = "fuzzel";
        assigns = {
          "1" = [{class = "^Alacritty$";}];
          "2" = [{class = "^Emacs$";}];
          "3" = [{class = "^firefox$";}];
        };
        bars = [];
        startup = [];
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
        settings."github.com" = {
          HostName = "github.com";
          User = "git";
          IdentityFile = "~/mnt/k/id_rsa.pub";
          IdentitiesOnly = true;
        };
      };

      waybar = {
        settings = [waybar];
      };

      git = {
        settings = {
          user = {
            email = "matthew@mexico86.co.uk";
          };
        };
        signing = {
          key = "0902EF0CB4879CEB";
          signByDefault = true;
        };
      };

      calibre = {
        enable = true;
      };

      glide-browser = {
        enable = true;
        profiles = {
          mryall = {
            id = 0;
            settings =
              firefoxCfg.settings
              // {
                "layout.css.devPixelsPerPx" = "1.5";
                "browser.uidensity" = 1;
              };
            userChrome = firefoxCfg.userChrome;
            search = firefoxCfg.search;
            extensions = {
              packages = with nur.repos.rycee.firefox-addons; [
                ghosttext
                org-capture
                privacy-badger
                sidebery
                tridactyl
                ublock-origin
                i-dont-care-about-cookies
              ];
            };
          };
        };
      };

      firefox = {
        profiles = {
          mryall = {
            settings =
              firefoxCfg.settings
              // {
                "layout.css.devPixelsPerPx" = "1.5";
                "browser.uidensity" = 1;
              };
          };
        };
      };
    };
  };
}
