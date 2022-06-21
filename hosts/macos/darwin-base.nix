{ config, pkgs, ... }:

{
  imports = [ ../nix-base.nix ];

  nix = {
    binaryCaches = [
      https://nix-community.cachix.org
    ];
    binaryCachePublicKeys = [
      nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=
    ];
  };

  environment = {
    shells = [ pkgs.zsh ];
    loginShell = "${pkgs.zsh}";
  };

  # Application environment
  launchd.user.envVariables.PATH = config.environment.systemPath;

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  programs = { };

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
        ralt - 3: open -a ~/Applications/Homebrew\ Apps/Firefox.app
        ralt - 4: open ~/.nix-profile/Applications/Slack.app
        ralt - 6: open -a ~/Applications/Homebrew\ Apps/KeePassXC.app
      '';
    };
    nix-daemon.enable = true;
  };

  fonts = {
    enableFontDir = true;
  };

  users = {
    nix = {
      configureBuildUsers = true;
    };
  };

  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";
    global = {
      brewfile = true;
      noLock = true;
    };
    extraConfig = ''
      cask_args appdir: "~/Applications/Homebrew Apps", require_sha: true
    '';
  };
}
