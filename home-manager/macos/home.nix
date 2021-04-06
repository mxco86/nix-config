{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports = [ ./base.nix ];

  programs = {
    git = {
      userName = "Matthew Ryall";
      userEmail = "matthew@mexico86.co.uk";
    };
  };
}
