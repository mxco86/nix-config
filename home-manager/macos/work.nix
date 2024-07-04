{ pkgs, username, ... }:

let
  adr-tools = import ../../pkgs/adr-tools { inherit pkgs; };
in
{
  imports = [ ./base.nix ];

  home-manager.users.${username} =
    { pkgs, ... }:
    {
      home = {
        username = "matt.ryall";
        homeDirectory = "/Users/matt.ryall";

        packages = with pkgs; [
          aws-vault
          # adr-tools
          # jetbrains.idea-community
          dive
          jwt-cli
          jira-cli-go
          pgformatter
          azure-cli
          kubectl
          kubelogin
          k9s
          ssm-session-manager-plugin
          tidyp
          tokei
          xh
          gh
          yq
          d2
          gron
        ];

        sessionVariables = {
          JIRA_EDITOR = "emacsclient";
          JIRA_API_TOKEN = "";
        };
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
            "*.delius-core-dev.internal *.delius.probation.hmpps.dsd.io *.delius-core.probation.hmpps.dsd.io 10.161.* 10.162.* !*.pre-prod.delius.probation.hmpps.dsd.io !*.stage.delius.probation.hmpps.dsd.io !*.perf.delius.probation.hmpps.dsd.io" = {
              user = "mryall";
              identityFile = "/Volumes/Q/k/id_rsa_delius";
              proxyCommand = "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p moj_dev_bastion";
              identitiesOnly = true;
            };
            "ssh.bastion-dev.probation.hmpps.dsd.io moj_dev_bastion awsdevgw" = {
              hostname = "ssh.bastion-dev.probation.hmpps.dsd.io";
              forwardAgent = true;
              user = "mryall";
              identityFile = "/Volumes/Q/k/id_rsa_delius";
              proxyCommand = "sh -c \"aws ssm start-session --target i-094ea35e707a320d4 --document-name AWS-StartSSHSession --parameters 'portNumber=%p'\"";
              identitiesOnly = true;
            };
            "*.probation.service.justice.gov.uk *.pre-prod.delius.probation.hmpps.dsd.io *.stage.delius.probation.hmpps.dsd.io 10.160.*" = {
              user = "mryall";
              identityFile = "/Volumes/Q/k/id_rsa_delius_prod";
              proxyCommand = "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p moj_prod_bastion";
              identitiesOnly = true;
            };
            "ssh.bastion-prod.probation.hmpps.dsd.io moj_prod_bastion awsprodgw" = {
              hostname = "ssh.bastion-prod.probation.hmpps.dsd.io";
              forwardAgent = true;
              user = "mryall";
              identityFile = "/Volumes/Q/k/id_rsa_delius_prod";
              proxyCommand = "sh -c \"aws ssm start-session --target i-0fba91ad072312e75 --document-name AWS-StartSSHSession --parameters 'portNumber=%p'\"";
              identitiesOnly = true;
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
    };
}
