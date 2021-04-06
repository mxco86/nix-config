{ config, lib, pkgs, ... }:

{
  imports = [ ./base.nix ];

  home = {
    packages = with pkgs; [
      adr-tools
    ];
  };

  programs = {
    ssh = {
      controlPersist = "yes";
      controlMaster = "auto";
      controlPath = "/tmp/%r@%h:%p";
      serverAliveInterval = 20;
      serverAliveCountMax = 2;

      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = "/Volumes/Q/k/id_rsa_moj";
          identitiesOnly = true;
        };
        "ssh.bastion-dev.probation.hmpps.dsd.io aws_proxy" = {
          hostname = "ssh.bastion-dev.probation.hmpps.dsd.io";
          user = "mryall";
          identityFile = "/Volumes/Q/k/id_rsa_delius";
        };
        "*.probation.hmpps.dsd.io" = {
          user = "mryall";
          identityFile = "/Volumes/Q/k/id_rsa_delius";
          proxyCommand = "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p aws_proxy";
        };
      };
    };
    git = {
      userName = "Matthew Ryall";
      userEmail = "matthew.ryall@digital.justice.gov.uk";
    };
  };
}
