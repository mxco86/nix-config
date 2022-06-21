{ config, pkgs, ... }:

{
  imports = [ ../nix-base.nix ./darwin-base.nix ];

  networking.hostName = "careca";

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix = {
    maxJobs = 8;
    buildCores = 0;
  };

  homebrew = {
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
      "docker"
      "spectacle"
      "vorta"
    ];
  };

  services = {
    skhd = {
      skhdConfig = ''
        ralt - 1: open -a /Applications/Safari.app
        ralt - 2: open /Applications/Slack.app
        ralt - 5: open /run/current-system/Applications/kitty.app
        ralt - 6: open /run/current-system/Applications/Emacs.app
        ralt - 7: open -a ~/Applications/Homebrew\ Apps/Firefox.app
        ralt - 8: open -a /System/Applications/Utilities/Terminal.app
        ralt - 9: open /Applications/Miro.app
      '';
    };
  };
}
