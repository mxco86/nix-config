# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

let
  tailscale-key = "";
in
{
  imports = [
    ./hardware-configuration.nix
    ../../nix-base.nix
    ../nixos-base.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  networking = {
    hostName = "rossi";
    domain = "mexico86.co.uk";
    useDHCP = false;
    interfaces.enp4s0.useDHCP = true;
    networkmanager = {
      enable = true;
      enableStrongSwan = true;
    };
    firewall = {
      checkReversePath = "loose";
      allowedTCPPorts = [
        8083
        2080
        8384
        22000
        44831
      ];
      allowedUDPPorts = [
        22000
        21027
      ];
    };
  };

  environment = {
    systemPackages = [
      pkgs.chrysalis
      pkgs.nfs-utils
      pkgs.caddy
    ];

    etc."ipsec.secrets".text = ''
      include ipsec.d/ipsec.nm-l2tp.secrets
    '';

    variables = {
      ROC_ENABLE_PRE_VEGA = "1";
    };
  };

  services = {
    udev.packages = [ pkgs.chrysalis ];
    udisks2 = {
      enable = true;
    };
    transmission = {
      enable = true;
      openFirewall = true;
    };
    syncthing = {
      enable = true;
      user = "mryall";
      dataDir = "/home/mryall/";
      configDir = "/home/mryall/.config/syncthing/";
      guiAddress = "0.0.0.0:8384";
    };
    calibre-web = {
      enable = true;
      openFirewall = true;
      user = "mryall";
      group = "users";
      listen = {
        ip = "100.108.44.78";
      };
      options = {
        calibreLibrary = "/home/mryall/Books/Calibre/";
        enableBookConversion = true;
      };
    };
    ollama = {
      enable = true;
      # acceleration = "rocm";
      models = "/tank/one/models";
    };
    prometheus = {
      exporters = {
        node = {
          enable = true;
          port = 9100;
          enabledCollectors = [
            "logind"
            "systemd"
          ];
          disabledCollectors = [ "textfile" ];
          openFirewall = true;
          firewallFilter = "-i br0 -p tcp -m tcp --dport 9100";
        };
      };
    };
    homepage-dashboard = {
      enable = true;
      settings = {
        title = "Homepage";
        headerStyle = "clean";
        layout = {
          Machines = {
            style = "row";
            columns = 3;
          };
          Services = {
            style = "row";
            columns = 3;
          };
          Development = {
            style = "row";
            columns = 3;
          };
          Syncthing = {
            style = "row";
            columns = 3;
          };
        };
      };
      bookmarks = [
        {
          Development = [
            {
              github = [
                {
                  href = "https://github.com/mxco86";
                  icon = "si-github.svg";
                }
              ];
            }
            {
              nixos = [
                {
                  abbr = "NX";
                  href = "https://search.nixos.org/options";
                  icon = "si-nixos.svg";
                }
              ];
            }
          ];
        }
      ];
      services = [
        {
          Syncthing = [
            {
              rossi = {
                description = "Rossi / Syncthing";
                icon = "si-syncthing.svg";
                href = "https://rossi:8384";
                siteMonitor = "https://rossi:8384";
              };
            }
            {
              maradona = {
                description = "Maradona / Syncthing";
                icon = "si-syncthing.svg";
                href = "https://maradona:8384";
                siteMonitor = "https://maradona:8384";
              };
            }
            {
              sanchez = {
                description = "Sanchez / Syncthing";
                icon = "si-syncthing.svg";
                href = "https://sanchez:8384";
                siteMonitor = "https://sanchez:8384";
              };
            }

          ];
        }
        {
          Machines = [
            {
              rossi = {
                description = "Workstation";
                icon = "si-nixos.svg";
                widget = {
                  type = "tailscale";
                  deviceid = "nHScKA4CNTRL";
                  key = tailscale-key;
                };
              };
            }
            {
              sanchez = {
                description = "Laptop";
                icon = "si-nixos.svg";
                widget = {
                  type = "tailscale";
                  deviceid = "n7GmEU2CNTRL";
                  key = tailscale-key;
                };
              };
            }
            {
              maradona = {
                description = "Services / NAS";
                icon = "si-freebsd.svg";
                widget = {
                  type = "tailscale";
                  deviceid = "nAPwmv3CNTRL";
                  key = tailscale-key;
                };
              };
            }
            {
              rpi-router = {
                description = "Tailscale Router";
                icon = "si-raspberrypi.svg";
                widget = {
                  type = "tailscale";
                  deviceid = "nSZvTY4CNTRL";
                  key = tailscale-key;
                };
              };
            }
            {
              olsen = {
                description = "NAS";
                icon = "si-qnap.svg";
                href = "https://192.168.1.121";
                widget = {
                  type = "qnap";
                  url = "https://192.168.1.121";
                  username = "admin";
                  password = "L1ch3n);";
                };
              };
            }
          ];
        }
        {
          Services = [
            {
              "Calibre Web" = {
                description = "EBook Library";
                icon = "si-calibre-web.svg";
                href = "http://100.108.44.78:8083";
                widget = {
                  type = "calibreweb";
                  url = "http://100.108.44.78:8083";
                  username = "admin";
                  password = "admin123";
                };
              };
            }
            {
              "Grafana" = {
                description = "Metrics";
                href = "http://maradona:3000";
                icon = "si-grafana.svg";
                widget = {
                  type = "grafana";
                  url = "http://maradona:3000";
                  username = "admin";
                  password = "admin";
                };
              };
            }
            {
              "Prometheus" = {
                description = "Metrics";
                href = "http://maradona:9090";
                icon = "si-prometheus.svg";
                widget = {
                  type = "prometheus";
                  url = "http://maradona:9090";
                };
              };
            }
            {
              "AlertManager" = {
                description = "Alerts";
                href = "http://maradona:9093";
                icon = "si-prometheus.svg";
                siteMonitor = "https://maradona:9003";
              };
            }

          ];
        }
      ];
      widgets = [
        {
          search = {
            provider = "duckduckgo";
            target = "_blank";
          };
        }
        {
          openmeteo = {
            label = "Millhouses";
            timezone = "Europe/London";
            latitude = "53.346607";
            longitude = "-1.499701";
            units = "metric";
          };
        }
      ];
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
