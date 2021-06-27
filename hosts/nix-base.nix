{ pkgs, ... }:

{

  imports = [ ../modules/emacs ];

  # Set your time zone.
  time = { timeZone = "Europe/London"; };

  nixpkgs = {
    config = { allowUnfree = true; };

    overlays = [
      (import (builtins.fetchTarball {
        url =
          "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
      }))
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      (aspellWithDicts (d: [ d.en ]))
      kitty
      mu
      vim
    ];
    pathsToLink = [ "/share/zsh" ];
  };

  fonts.fonts = with pkgs; [
    dejavu_fonts
    hack-font
    noto-fonts-emoji
    font-awesome
  ];

  programs = {
    zsh = { enable = true; };
    tmux = { enable = true; };
    emacsWithMJRPackages = { enable = true; };
  };
}
