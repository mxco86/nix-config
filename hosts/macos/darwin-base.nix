{ config, pkgs, ... }:

{
  imports = [ ../nix-base.nix ];

  environment = {
    shells = [ pkgs.zsh ];
    loginShell = "${pkgs.zsh}";
  };

  # Application environment
  launchd.user.envVariables.PATH = config.environment.systemPath;

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  programs = {
    tmux = {
      enableSensible = true;
      enableMouse = true;
      extraConfig = ''
        bind-key -T copy-mode MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
      '';
    };

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

  services = {
    skhd = {
      enable = true;
      skhdConfig = ''
        ralt - 1: open /run/current-system/Applications/kitty.app
        ralt - 2: open /run/current-system/Applications/Emacs.app
        ralt - 3: open /Applications/Firefox.app
        ralt - 4: open ~/.nix-profile/Applications/Slack.app
      '';
    };
  };

  fonts = { enableFontDir = true; };

  users = {
    nix = {
      configureBuildUsers = true;
    };
  };
}
