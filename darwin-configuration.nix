{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];

  # Emacs
  environment = {
    systemPackages = with pkgs; [
      vim
      mu
      (aspellWithDicts (d: [d.en]))
      (import ./modules/emacs.nix { inherit pkgs; })
    ];

    pathsToLink = [ "/share/zsh" ];
  };

  # Application environment
  launchd.user.envVariables.PATH = config.environment.systemPath;

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  programs.zsh.enable = true;

  programs.tmux = {
    enable = true;
    enableSensible = true;
    enableMouse = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 4;
  nix.buildCores = 1;

  # Trackpad variables
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;

  # Keyboard variables
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  # Spaces / Dock
  system.defaults.dock.mru-spaces = false;
  system.defaults.dock.show-recents = false;
  system.defaults.dock.tilesize = 32;

  # Fonts
  fonts.enableFontDir = true;
  fonts.fonts = with pkgs; [
    dejavu_fonts
    hack-font
  ];
}
