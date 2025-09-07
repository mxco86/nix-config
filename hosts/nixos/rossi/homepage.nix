let
  tailscale-key = "";
in
  {}: {
    enable = true;
    allowedHosts = "localhost:8082,rossi:8082";
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
          {
            home-manager = [
              {
                abbr = "NXHM";
                href = "https://home-manager-options.extranix.com/";
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
                deviceid = "nSg4GueJz721CNTRL";
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
                password = "";
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
  }
