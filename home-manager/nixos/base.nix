{ pkgs, ... }:

{
  imports = [ ../base.nix ];

  home-manager.users.mryall = { pkgs, ... }: {
    home = {
      username = "mryall";
      homeDirectory = "/home/mryall";
      stateVersion = "22.05";

      packages = with pkgs; [
        anki
        authy
        # discord
        unzip
        xclip
        xorg.xdpyinfo
        xorg.xmodmap
        ssm-session-manager-plugin
        (makeDesktopItem {
          name = "org-protocol";
          exec = "emacsclient %u";
          comment = "Org protocol";
          desktopName = "org-protocol";
          type = "Application";
          mimeTypes = [ "x-scheme-handler/org-protocol" ];
        })
      ];

      keyboard = { options = [ "ctrl:nocaps" ]; };

      sessionVariables = {
        MOZ_ENABLE_WAYLAND = "1";
        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "sway";
      };

      file = {
        wofi = {
          source = ../files/wofi_stylesheet.css;
          target = ".config/wofi/style.css";
        };
      };
    };

    gtk = {
      enable = true;
      gtk3 = {
        extraConfig = {
          gtk-key-theme-name = "Emacs";
        };
      };
    };

    programs = {
      rofi = {
        enable = true;
        pass = { enable = true; };
      };

      wofi = {
        enable = true;
        settings = {
          stylesheet = "style.css";
          width = 600;
          height = 300;
          location = "center";
          show = "drun";
          prompt = "Search...";
          filter_rate = 100;
          allow_markup = true;
          no_actions = true;
          halign = "fill";
          orientation = "vertical";
          content_halign = "fill";
          insensitive = true;
          allow_images = true;
          image_size = 20;
          key_up = "Control_L-p";
          key_down = "Control_L-n";
        };
      };

      waybar = {
        enable = true;
        systemd.enable = true;

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

          #network, #backlight, #cpu, #memory, #temperature, #battery,
          #wireplumber, #wireplumber.muted, #clock, #disk {
            background-color: #002b36;
            color: #fdf6e3;
          }
        '';
      };

      git = {
        extraConfig = {
          credential = {
            helper = "git-credential-libsecret";
          };
        };
      };

      firefox = {
        package = (pkgs.firefox.override {
          extraNativeMessagingHosts = [
            pkgs.passff-host
          ];
          cfg = { enableTridactylNative = true; };
        });
      };
    };

    services = {
      syncthing = { enable = true; };
      twmn = {
        enable = true;
        window = {
          height = 28;
          color = "#002b36";
        };
        text = {
          color = "#6c71c4";
          font = {
            family = "Hack";
            variant = "medium";
            size = 18;
          };
        };
      };
      gpg-agent = {
        enable = true;
        enableSshSupport = true;
        enableExtraSocket = true;
        pinentryFlavor = "gtk2";
        defaultCacheTtl = 34560000;
        maxCacheTtl = 34560000;
        defaultCacheTtlSsh = 34560000;
        maxCacheTtlSsh = 34560000;
        extraConfig = ''
          allow-emacs-pinentry
          allow-loopback-pinentry
        '';
      };
    };

    wayland.windowManager.sway = {
      enable = true;
      systemd.enable = true;
      config = {
        modifier = "Mod4";
        keybindings =
          let modifier = "Mod4"; in
          pkgs.lib.mkOptionDefault {
            "${modifier}+p" = "exec ${pkgs.rofi-pass}/bin/rofi-pass";
          };
        focus = { newWindow = "focus"; };
        workspaceAutoBackAndForth = true;
        colors = {
          focused = {
            background = "#002b36";
            border = "#586e75";
            childBorder = "#586e75";
            indicator = "#268bd2";
            text = "#fdf6e3";
          };
        };
        fonts = {
          names = [ "FontAwesome" "Iosevka" ];
        };
        terminal = "${pkgs.alacritty}/bin/alacritty";
      };
    };
  };
}
