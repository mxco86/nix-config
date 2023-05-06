{ config, lib, pkgs, username, ... }:

{
  imports = [ ./base.nix ];

  home-manager.users.${username} = { pkgs, ... }: {
    home = {
      username = "mryall";
      homeDirectory = "/Users/mryall";
    };

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
  };
}
