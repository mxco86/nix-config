{ pkgs, ... }:

{

  imports = [ ../modules/emacs ];

  # Set your time zone.
  time = { timeZone = "Europe/London"; };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs = {
    config = { allowUnfree = true; };
  };

  environment = {
    systemPackages = with pkgs; [
      kitty
      vim
      tailscale
    ];
    pathsToLink = [ "/share/zsh" ];
  };

  fonts.fonts = with pkgs; [
    dejavu_fonts
    hack-font
    font-awesome
  ];

  programs = {
    zsh = { enable = true; };
    emacsWithMJRPackages = { enable = true; };
  };
}
