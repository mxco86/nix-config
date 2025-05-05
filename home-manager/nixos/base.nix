{pkgs, ...}: {
  imports = [../base.nix];

  home-manager.users.mryall = {pkgs, ...}: {
    home = {
      username = "mryall";
      homeDirectory = "/home/mryall";
      stateVersion = "22.05";

      packages = with pkgs; [
        # anki
        # authy
        beets
        # picard
        # discord
        unzip
        # xclip
        # xorg.xdpyinfo
        # xorg.xmodmap
        # ssm-session-manager-plugin
        # yubikey-manager
        soco-cli
        trippy
        vale
        (makeDesktopItem {
          name = "org-protocol";
          exec = "emacsclient %u";
          comment = "Org protocol";
          desktopName = "org-protocol";
          type = "Application";
          mimeTypes = ["x-scheme-handler/org-protocol"];
        })
      ];

      keyboard = {
        options = ["ctrl:nocaps"];
      };

      sessionVariables = {
        MOZ_ENABLE_WAYLAND = "1";
        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "sway";
      };

      file = {
        vale = {
          source = ../files/vale.ini;
          target = ".config/vale/.vale.ini";
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

    xdg = {
      desktopEntries = {
        miro = {
          name = "Miro";
          genericName = "Web Browser";
          exec = "firefox -new-instance -P miro";
          terminal = false;
          categories = [
            "Application"
            "WebBrowser"
          ];
          mimeType = [
            "text/html"
            "text/xml"
          ];
        };
      };
    };

    programs = {
      fuzzel = {
        enable = true;
        settings = {
          main = {
            font = "Iosevka";
          };
          colors = {
            background = "#002b36fa";
            selection = "#073642fa";
            border = "#928374fa";
          };
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
        package = (
          pkgs.firefox.override {
            nativeMessagingHosts = [
              pkgs.tridactyl-native
              pkgs.passff-host
            ];
          }
        );
      };
    };

    services = {
      mako = {
        enable = true;
        settings = {
          font = "Iosevka 12";
          backgroundColor = "#002b36";
          textColor = "#fdf6e3";
          borderColor = "#b58900";
        };
      };
      gpg-agent = {
        enable = true;
        enableSshSupport = true;
        enableExtraSocket = true;
        pinentry = {package = pkgs.pinentry-qt;};
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
        keybindings = let
          modifier = "Mod4";
        in
          pkgs.lib.mkOptionDefault {"${modifier}+p" = "exec ${pkgs.rofi-pass}/bin/rofi-pass";};
        focus = {
          newWindow = "focus";
        };
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
          names = [
            "FontAwesome"
            "Iosevka"
          ];
        };
        terminal = "${pkgs.alacritty}/bin/alacritty";
      };
    };
  };
}
