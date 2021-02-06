{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  imports = [ ../base.nix ];

  networking.hostName = "socrates";

  environment = {
    shells = [ pkgs.zsh ];
    loginShell = "${pkgs.zsh}";
  };

  # Application environment
  launchd.user.envVariables.PATH = config.environment.systemPath;

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs = {
    tmux = {
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

  fonts = { enableFontDir = true; };
}
