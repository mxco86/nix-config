{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports = [ ./base.nix ];

  programs = {
    git = {
      userName = "Matthew Ryall";
      userEmail = "matthew@mexico86.co.uk";
    };
    ssh = {
      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/id_rsa";
          identitiesOnly = true;
        };
      };
    };
  };
}
