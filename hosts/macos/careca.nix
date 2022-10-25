{ config, pkgs, ... }:

{
  imports = [ ../nix-base.nix ./darwin-base.nix ];

  networking.hostName = "careca";

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix = {
    settings = {
      max-jobs = 8;
      cores = 0;
    };
  };

  homebrew = {
    brewPrefix = "/opt/homebrew/bin";

    taps = [
      "homebrew/core"
      "homebrew/cask"
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
        ralt - 1: open -a /Applications/Safari.app
        ralt - 2: open /run/current-system/Applications/Emacs.app
        ralt - 3: open -a ~/Applications/Homebrew\ Apps/Firefox.app
        ralt - 4: open /Applications/Slack.app
        ralt - 6: open /run/current-system/Applications/kitty.app
        ralt - 9: open /Applications/Miro.app
      '';
    };
  };
}
