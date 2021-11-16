{ config, pkgs, ... }:

{
  imports = [ ../nix-base.nix ./darwin-base.nix ];

  networking.hostName = "careca";

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix = {
    maxJobs = 4;
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
      "hyperkit"
    ];

    casks = [
      "firefox"
      "docker"
      "spectacle"
      "vorta"
      "keepassxc"
    ];
  };

  services = {
    skhd = {
      skhdConfig = ''
        ralt - 6: open /Applications/KeePassXC.app
      '';
    };
  };
}
