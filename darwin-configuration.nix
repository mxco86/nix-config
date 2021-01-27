{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  nixpkgs = {
    config = { allowUnfree = true; };

    overlays = [
      (import (builtins.fetchTarball {
        url =
          "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
      }))
    ];
  };

  # Emacs
  environment = {
    shells = [pkgs.zsh];
    loginShell = "${pkgs.zsh}";
    systemPackages = with pkgs; [
      vim
      mu
      chroma
      (aspellWithDicts (d: [ d.en ]))
      (import ./modules/emacs.nix { inherit pkgs; })
    ];

    pathsToLink = [ "/share/zsh" ];
  };

  # Application environment
  launchd.user.envVariables.PATH = config.environment.systemPath;

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs = {
    bash = { enable = true; };
    zsh = { enable = true; };
    tmux = {
      enable = true;
      enableSensible = true;
      enableMouse = true;
      extraConfig = ''
        bind-key -T copy-mode MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
      '';
    };
  };

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix = {
    maxJobs = 4;
    buildCores = 1;
  };

  system = {
    # Used for backwards compatibility, please read the changelog before changing.
    stateVersion = 4;

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    defaults = {
      NSGlobalDomain = {
        # Trackpad variables
        "com.apple.swipescrolldirection" = false;
      };
      dock = {
        mru-spaces = false;
        show-recents = false;
        tilesize = 32;
        autohide = false;
      };
    };
  };

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [ dejavu_fonts hack-font ];
  };
}
