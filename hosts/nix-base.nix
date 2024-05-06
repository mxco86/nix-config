{ nixpkgs, pkgs, ... }:

{

  imports = [ ../modules/emacs ../cachix.nix ];

  # Set your time zone.
  time = { timeZone = "Europe/London"; };

  nix = {
    package = pkgs.nixVersions.latest;
    registry.nixpkgs.flake = nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      extra-platforms = x86_64-darwin aarch64-darwin
      trusted-users = root mryall
    '';
  };

  environment = {
    systemPackages = with pkgs; [ vim cachix python3 ];
    pathsToLink = [ "/share/zsh" ];
  };

  fonts.packages = with pkgs; [ dejavu_fonts iosevka fira-code font-awesome ];

  programs = {
    zsh = { enable = true; };
    emacsWithMJRPackages = { enable = true; };
  };
}
