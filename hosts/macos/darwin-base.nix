{ config, pkgs, x86pkgs, ... }:

{
  imports = [ ../nix-base.nix ];

  nix = {
    configureBuildUsers = true;
  };

  users.users.mryall = {
    name = "mryall";
    home = "/Users/mryall";
  };

  users.users."matthew.ryall" = {
    name = "matthew.ryall";
    home = "/Users/matthew.ryall";
  };

  environment = {
    shells = [ pkgs.zsh ];
    loginShell = "${pkgs.zsh}";

    systemPackages = [
      pkgs.alacritty
    ];
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
      '';
    };
    nix-daemon = { enable = true; };
    tailscale = {
      enable = true;
    };
  };

  networking = {
    knownNetworkServices = [ "Wi-Fi" ];
    dns = [ "192.168.1.66" ];
  };

  fonts = {
    fontDir = { enable = true; };
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    global = {
      brewfile = true;
      lockfiles = true;
    };
    caskArgs = {
      appdir = "~/Applications/Homebrew Apps";
      require_sha = true;
    };
  };
}
