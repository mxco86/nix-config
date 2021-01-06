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
  environment.systemPackages = with pkgs; [
    vim
    aspell
    aspellDicts.en
    (emacsWithPackagesFromUsePackage {
      config = ~/.emacs;
      extraEmacsPackages = epkgs: [
        epkgs.ace-window
        epkgs.add-node-modules-path
        epkgs.ag
        epkgs.base16-theme
        epkgs.company
        epkgs.company-org-roam
        epkgs.counsel
        epkgs.dap-mode
        epkgs.direnv
        epkgs.docker
        epkgs.flx
        epkgs.flycheck
        epkgs.flycheck-kotlin
        epkgs.forge
        epkgs.ivy
        epkgs.js2-mode
        epkgs.kotlin-mode
        epkgs.lsp-ivy
        epkgs.lsp-java
        epkgs.lsp-mode
        epkgs.magit
        epkgs.nix-mode
        epkgs.org-download
        epkgs.org-roam
        epkgs.org-roam-server
        epkgs.paredit
        epkgs.prettier-js
        epkgs.projectile
        epkgs.racket-mode
        epkgs.smex
        epkgs.spaceline
        epkgs.typescript-mode
        epkgs.use-package
        epkgs.use-package-ensure-system-package
        epkgs.which-key
        epkgs.yaml-mode
      ];
    })
  ];

  # Application environment
  launchd.user.envVariables.PATH = config.environment.systemPath;

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  programs.zsh.enable = true;
  # programs.fish.enable = true;

  programs.tmux = {
    enable = true;
    extraConfig = ''
       set-option -g default-shell $SHELL
       setw -g mouse on
       bind-key -T copy-mode MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
    '';
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
