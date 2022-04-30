{ pkgs, ... }:

{
  imports = [ ./base.nix ];

  xresources = {
    properties = {
      "Xft.dpi" = 144;
      "Xft.antialias" = true;
      "Xft.rgba" = "rgb";
      "Xft.hinting" = true;
      "Xft.hintstyle" = "hintslight";
    };
  };

  xsession.windowManager.i3 = {
    config = {
      assigns = {
        "1: emacs" = [{ class = "^Emacs$"; }];
        "2: slack" = [{ class = "^Slack$"; }];
        "4: web" = [{ class = "^Firefox$"; }];
        "3: term" = [{ class = "^kitty$"; }];
      };
    };
    extraConfig = ''
      '';
  };

  programs = {
    i3status = {
      enable = true;
      enableDefault = false;
      general = {
        colors = true;
        color_good = "#6c71c4";
        color_degraded = "#b58900";
        color_bad = "#dc322f";
        color_separator = "#657b83";
        interval = 5;
      };
      modules = {
        ipv6 = {
          position = 1;
        };
        load = {
          position = 2;
        };
        memory = {
          position = 3;
        };
        "tztime local" = {
          position = 4;
        };
      };
    };

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
          identityFile = "~/mnt/k/id_rsa_moj";
          identitiesOnly = true;
        };
        "ssh.bastion-dev.probation.hmpps.dsd.io aws_proxy_dev" = {
          hostname = "ssh.bastion-dev.probation.hmpps.dsd.io";
          user = "mryall";
          identityFile = "~/mnt/k/id_rsa_delius";
          identitiesOnly = true;
        };
        "ssh.bastion-prod.probation.hmpps.dsd.io aws_proxy_prod" = {
          hostname = "ssh.bastion-prod.probation.hmpps.dsd.io";
          user = "mryall";
          identityFile = "~/mnt/k/id_rsa_delius_prod";
          identitiesOnly = true;
        };
        "*.test.delius.probation.hmpps.dsd.io" = {
          user = "mryall";
          identityFile = "~/mnt/k/id_rsa_delius";
          proxyCommand = "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p aws_proxy_dev";
          identitiesOnly = true;
        };
        "*.pre-prod.delius.probation.hmpps.dsd.io" = {
          user = "mryall";
          identityFile = "~/mnt/k/id_rsa_delius_prod";
          proxyCommand = "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p aws_proxy_prod";
          identitiesOnly = true;'
        };
      };
    };

    firefox = {
      profiles = {
        mryall = {
          settings = {
            "browser.uidensity" = 1;
          };
        };
      };
    };
  };
}
