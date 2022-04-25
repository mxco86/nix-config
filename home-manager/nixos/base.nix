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

    rofi = {
      enable = true;
      pass = { enable = true; };
    };

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
          identityFile = "~/mnt/k/id_rsa.pub";
          identitiesOnly = true;
        };
      };
    };

    firefox = {
      package = (pkgs.firefox.override {
        extraNativeMessagingHosts = [ pkgs.passff-host ];
      });
      profiles = {
        mryall = {
          userChrome = ''
            #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
                display:none;
            }

            #urlbar { font-size: 12pt !important }
            #statuspanel { font-size: 12pt !important }
            #main-menubar { font-size: 12pt !important }

            menubar, menubutton, menulist, menu, menuitem,
            textbox, findbar, toolbar, tab, tree, tooltip {
              font-size: 12pt !important;
            }

            .tabbrowser-tab {
               min-height: var(--tab-min-height) !important;
               overflow: visible !important;
               font-size: 12pt !important;
               background: 0 !important;
               border: 0 !important;
            }
          '';
        };
      };
    };
  };

  services = {
    syncthing = { enable = true; };
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableExtraSocket = true;
      pinentryFlavor = "gtk2";
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
      menu = "rofi -modi drun -show drun -theme solarized -font 'Hack 22'";
      keybindings =
        let modifier = "Mod4"; in
        pkgs.lib.mkOptionDefault {
          "${modifier}+p" = "exec ${pkgs.rofi-pass}/bin/rofi-pass";
        };
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
