{ config, lib, pkgs, ... }:

let
  adr-tools = import ../../pkgs/adr-tools { inherit pkgs; };
in
{
  imports = [ ./base.nix ];

  home = {
    username = "matthew.ryall";
    homeDirectory = "/Users/matthew.ryall";

    packages = with pkgs; [
      # adoptopenjdk-hotspot-bin-11
      # adr-tools
      # dbeaver
      # jetbrains.idea-community
      # kubectl
      # docker
      # docker-compose
      # minikube
      # jwt-cli
      # imagemagick
      python3
      pgformatter
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
        "ssh.bastion-dev.probation.hmpps.dsd.io aws_proxy_dev" = {
          hostname = "ssh.bastion-dev.probation.hmpps.dsd.io";
          user = "mryall";
          identityFile = "/Volumes/Q/k/id_rsa_delius";
        };
        "ssh.bastion-prod.probation.hmpps.dsd.io aws_proxy_prod" = {
          hostname = "ssh.bastion-prod.probation.hmpps.dsd.io";
          user = "mryall";
          identityFile = "/Volumes/Q/k/id_rsa_delius_prod";
        };
        "*.test.delius.probation.hmpps.dsd.io" = {
          user = "mryall";
          identityFile = "/Volumes/Q/k/id_rsa_delius";
          proxyCommand = "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p aws_proxy_dev";
        };
        "*.pre-prod.delius.probation.hmpps.dsd.io" = {
          user = "mryall";
          identityFile = "/Volumes/Q/k/id_rsa_delius_prod";
          proxyCommand = "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p aws_proxy_prod";
        };
      };
    };
    git = {
      userName = "Matthew Ryall";
      userEmail = "matthew.ryall@digital.justice.gov.uk";
      signing = {
        key = "0902EF0CB4879CEB";
        signByDefault = true;
      };
    };
  };
}
