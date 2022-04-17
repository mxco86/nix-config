{ pkgs, ... }:

{
  imports = [ ../base.nix ];

  home = {
    packages = with pkgs; [
      anki
      discord
      keepassxc
      xclip
      xorg.xdpyinfo
      xorg.xmodmap
    ];

    keyboard = { options = [ "ctrl:nocaps" ]; };
  };

  programs = {
    kitty = { settings = { font_size = 10; }; };

    git = {
      userName = "Matthew Ryall";
      userEmail = "matthew@mexico86.co.uk";
      extraConfig = {
        credential = {
          helper = "git-credential-libsecret";
        };
      };
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

    firefox = {
      package = (pkgs.firefox.override {
        extraNativeMessagingHosts = [ pkgs.passff-host ];
      });
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
  };

  services = {
    syncthing = { enable = true; };
    gpg-agent = {
      enable = true;
      extraConfig = ''
        allow-emacs-pinentry
        allow-loopback-pinentry
      '';
    };
  };

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      bars = [{
        position = "top";
        statusCommand = "${pkgs.i3status}/bin/i3status";
        colors = {
          background = "#002b36";
          separator = "#657b83";
          statusline = "#fdf6e3";
          focusedWorkspace = {
            background = "#586e75";
            border = "#93a1a1";
            text = "#fdf6e3";
          };
          inactiveWorkspace = {
            background = "#002b36";
            border = "#073642";
            text = "#657b83";
          };
        };
        fonts = { names = [ "FontAwesome 8" "Hack 8" ]; };
        extraConfig = ''
          separator_symbol 
        '';
      }];
      colors = {
        focused = {
          background = "#002b36";
          border = "#586e75";
          childBorder = "#586e75";
          indicator = "#268bd2";
          text = "#fdf6e3";
        };
      };
      fonts = { names = [ "FontAwesome 8" "Hack 8" ]; };
      terminal = "${pkgs.kitty}/bin/kitty";
      assigns = {
        "1: term" = [{ class = "^kitty$"; }];
        "2: emacs" = [{ class = "^Emacs$"; }];
        "3: web" = [{ class = "^Firefox$"; }];
        "6: key" = [{ class = "^KeePassXC$"; }];
        "0: extra" = [{
          class = "^Firefox$";
          window_role = "About";
        }];
      };
    };
  };
}
