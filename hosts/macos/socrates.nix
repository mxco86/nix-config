{ config, pkgs, ... }:

{
  imports = [ ../nix-base.nix ./darwin-base.nix ];

  networking.hostName = "socrates";

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix = {
    maxJobs = 2;
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
      "vorta"
      "virtualbox"
    ];

    masApps = {
      Tailscale = 1475387142;
    };
  };

  services = {
    skhd = {
      skhdConfig = ''
        ralt - 1: open /run/current-system/Applications/kitty.app
        ralt - 2: open /run/current-system/Applications/Emacs.app
        ralt - 3: open -a ~/Applications/Homebrew\ Apps/Firefox.app
      '';
    };
  };
}
