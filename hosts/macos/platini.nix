{
  config,
  pkgs,
  ...
}: {
  imports = [../nix-base.nix ./darwin-base.nix];

  networking = {
    hostName = "platini";
    dns = ["192.168.1.66"];
  };

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix = {
    settings = {
      max-jobs = 8;
      cores = 0;
    };
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
      "authy"
      "firefox"
      "mediaelch"
      # "jaikoz"
      "steam"
      "origin"
      "spectacle"
      "calibre"
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
