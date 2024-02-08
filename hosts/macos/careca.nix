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
      "homebrew/services"
    ];

    brews = [
      "syncthing"
      "docker"
      "docker-compose"
      "colima"
    ];

    casks = [
      "firefox"
      "spectacle"
      "vorta"
      "slack"
    ];
  };

  services = {
    skhd = {
      skhdConfig = ''
        ralt - 1: open /run/current-system/Applications/Alacritty.app
        ralt - 2: open /run/current-system/Applications/Emacs.app
        ralt - 3: open -a /Applications/Safari.app
        ralt - 4: open /Applications/Slack.app
        ralt - 5: open ~/Applications/Home\ Manager\ Apps/DBeaver.app
        ralt - 7: open /run/current-system/Applications/Emacs.app
        ralt - 8: open -a ~/Applications/Homebrew\ Apps/Firefox.app
        ralt - 9: open /Applications/Miro.app
        ralt - 6: open /run/current-system/Applications/Alacritty.app; zellij action go-to-tab 1
      '';
    };
  };
}
