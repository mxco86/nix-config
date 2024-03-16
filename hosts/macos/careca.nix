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
      "docker"
      "docker-compose"
      "colima"
    ];

    casks = [
      "firefox"
      "rectangle"
      "vorta"
      "slack"
      "1password"
      "1password-cli"
      "miro"
    ];
  };

  services = {
    skhd = {
      skhdConfig = ''
        ralt - 1: open -a /Applications/Safari.app
        ralt - 2: open /Applications/Slack.app
        ralt - 3: open -a ~/Applications/Homebrew\ Apps/Firefox.app
        ralt - 4: open /run/current-system/Applications/Alacritty.app; zellij action go-to-tab 1
        ralt - 5: open /run/current-system/Applications/Alacritty.app;
        ralt - 6: open /run/current-system/Applications/Emacs.app
        ralt - 7: open ~/Applications/Homebrew\ Apps/Miro.app
        ralt - 9: open ~/Applications/Home\ Manager\ Apps/DBeaver.app
      '';
    };
  };
}



