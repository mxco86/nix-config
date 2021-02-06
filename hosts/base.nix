{ pkgs, ... }:

{

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
      vim
      mu
      (aspellWithDicts (d: [ d.en ]))
      (import ../modules/emacs/default.nix { inherit pkgs; })
    ];

    pathsToLink = [ "/share/zsh" ];
  };

  fonts.fonts = with pkgs; [ dejavu_fonts hack-font ];

  programs = {
    zsh = { enable = true; };
    tmux = { enable = true; };
  };

  services = { openssh.enable = true; };

}
