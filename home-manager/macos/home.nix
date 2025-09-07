{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./base.nix];

  programs = {
    git = {
      userName = "Matthew Ryall";
      userEmail = "matthew@mexico86.co.uk";
      signing = {
        key = "0902EF0CB4879CEB";
        signByDefault = true;
      };
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
