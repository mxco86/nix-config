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
      "vorta"
      # "keepassxc"
    ];

    # masApps = {
    #   Tailscale = 1475387142;
    # };
  };
}
