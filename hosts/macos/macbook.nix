{ config, pkgs, ... }:

{
  imports = [ ../nix-base.nix ./darwin-base.nix ];

  networking.hostName = "socrates";

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix = {
    maxJobs = 4;
    buildCores = 0;
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
      cask "firefox", args: { language: "en-GB" }
    '';

    taps = [
      "homebrew/core"
      "homebrew/cask"
    ];

    brews = [
      "syncthing"
    ];

    casks = [
      "firefox"
      "mediaelch"
      "jaikoz"
      "steam"
    ];

    # masApps = {
    #   Tailscale = 1475387142;
    # };
  };
}
