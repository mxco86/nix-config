{ config, pkgs, ... }:

{
  imports = [ ../nix-base.nix ./darwin-base.nix ];

  networking.hostName = "socrates";

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix = {
    settings = {
      max-jobs = 4;
      cores = 0;
    };
  };

  homebrew = {
    taps = [
      "homebrew/services"
    ];

    brews = [
      "syncthing"
    ];

    casks = [
      "firefox"
      "spectacle"
      "vorta"
    ];
  };

  services = {
    skhd = {
      skhdConfig = ''
        ralt - 1: open /run/current-system/Applications/Alacritty.app
        ralt - 2: open /run/current-system/Applications/Emacs.app
        ralt - 3: open -a ~/Applications/Homebrew\ Apps/Firefox.app
      '';
    };
  };
}
