{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      alacritty
      wl-clipboard
      nfs-utils
    ];
    etc."greetd/environments".text = ''
      sway
    '';
  };

  programs = {
    sway = {
      enable = true;
    };
  };

  services = {
    openssh = {
      enable = true;
    };

    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
    dbus.packages = [ pkgs.dconf ];

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    greetd = {
      enable = true;
      settings = {
        default_session.command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --user-menu --cmd sway
        '';
      };
    };

  };

  # Enable the docker daemon
  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    groups = {
      mryall = {
        gid = 1000;
      };
    };
    users = {
      mryall = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "audio"
          "docker"
          "mryall"
        ];
        shell = pkgs.fish;
        openssh = {
          authorizedKeys = {
            keys = [
              "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDzki+3Vf55XPa42/Y8nKBOsX2BBiv48bOfpDxAqhgOSpTgCAsEFs90Rd5BQdXEHmRsjkFZDe/YL0WHWmfuwWUS3sBn2dfD3MPpZnyPQNFOFN+uO7Of3ocNLXfpMIvbb3sXZRnff4V8CTXHffhYfGuHNQjS4SzMrEosxuZFM0kufwqT55SGtuHSuyGEjUIXAZ5wBPw69IIejkKGjBzOAYHt7jUWdMobodrGJ3NHgJUtv+fGjPvPRo/S+0GvRK5XirNUfkJG7PglGx/PhlyJhFbOXcGTVoxwFBTz4ODOzda+9vhl9VAbjrluuxqnFOLfXGiMszePtDPW4YEeK2b9yr6syuP6efIZ/Ab/nsWLuwgOwbAzJAxyy56AF4qSvLhW3L8ZiNwTUQlUauLr/bK0pl7wgSpB6mYid8apkYnOYQwVwj4WiyYIAclci+lI99J5r3XIPndRN4gt7gRgE6JO+vsrl1hY1nKwGulAnKDT1hoaX33ZfMkPgXhpYKFVFSlGpi9bTLzXFUBLUmNN8OQIN7Hv4V6sCvs2b08rr7kgQ7ObzlCFGQD+N18K5fJu29oUFw9wzgX7+eo9Tb+9RYeV9rC3Yzd2GtM8XgY64HatPQLSQ9FS2E7GOGNlaXgIKeIs/Bw37j9CwjileqNYIWNfw/QENHnIn+vIVPxXudodfKEu3w=="
            ];
          };
        };
      };
    };
  };
}
