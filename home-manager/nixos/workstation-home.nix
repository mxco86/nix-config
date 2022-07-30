{ pkgs, ... }:

let
  i3bar = import ./i3bar.nix { inherit pkgs; size = 12.0; };
in
{
  imports = [ ./base.nix ];

  xresources = {
    properties = {
      "Xft.dpi" = 96;
      "Xft.antialias" = true;
      "Xft.rgba" = "rgb";
      "Xft.hinting" = true;
      "Xft.hintstyle" = "hintslight";
    };
  };

  xsession.windowManager.i3 = {
    config = {
      assigns = {
        "1: code" = [
          { class = "^kitty$"; }
          { class = "^Emacs$"; }
        ];
        "2: slack" = [{ class = "^Slack$"; }];
        "3: web" = [{ class = "^firefox$"; }];
        "6: db" = [{ class = "^DBeaver$"; }];
      };
      bars = [ i3bar ];
      workspaceOutputAssign = [
        {
          workspace = "1: code";
          output = "DisplayPort-1";
        }
        {
          workspace = "2: slack";
          output = "DisplayPort-1";
        }
        {
          workspace = "3: web";
          output = "DVI-D-0";
        }
        {
          workspace = "6: db";
          output = "DVI-D-0";
        }
      ];
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
          identitiesOnly = true;
        };
      };
    };

    firefox = {
      profiles = {
        mryall = {
          settings = {
            "browser.uidensity" = 1;
          };
          userChrome = ''
            #TabsToolbar { visibility: collapse !important; }

            #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
                display:none;
            }

            #urlbar { font-size: 12pt !important }
            #statuspanel { font-size: 12pt !important }
            #main-menubar { font-size: 12pt !important }

            menubar, menubutton, menulist, menu, menuitem,
            textbox, findbar, toolbar, tab, tree, tooltip {
              font-size: 12pt !important;
            }

            .tabbrowser-tab {
               min-height: var(--tab-min-height) !important;
               overflow: visible !important;
               font-size: 12pt !important;
               background: 0 !important;
               border: 0 !important;
            }
          '';

        };
      };
    };
  };
}
