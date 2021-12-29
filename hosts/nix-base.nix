{ pkgs, ... }:

{

  imports = [ ../modules/emacs ];

  # Set your time zone.
  time = { timeZone = "Europe/London"; };

  nixpkgs = {
    config = { allowUnfree = true; };
  };

  environment = {
    systemPackages = with pkgs; [
      kitty
      mu
      vim
      tailscale
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
