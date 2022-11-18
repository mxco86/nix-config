{ pkgs, ... }:

{
  imports = [ ../base.nix ];

  home = {
    username = "mryall";
    homeDirectory = "/home/mryall";
    stateVersion = "22.05";

    packages = with pkgs; [
      anki
      dbeaver
      # discord
      jetbrains.idea-community
      nixpkgs-fmt
      unzip
      xclip
      xorg.xdpyinfo
      xorg.xmodmap
      ssm-session-manager-plugin
    ];

    keyboard = { options = [ "ctrl:nocaps" ]; };
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

    firefox = {
      package = (pkgs.firefox.override {
        extraNativeMessagingHosts = [ pkgs.passff-host ];
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

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      menu = "rofi -modi drun -show drun -theme solarized -font 'Hack 12'";
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
        names = [ "FontAwesome" "Hack" ];
        size = 10.0;
      };
      terminal = "${pkgs.kitty}/bin/kitty";
    };
  };
}
