# Edit this configuration file to define what should be installed on“Bezos embodies an economic and social model that is leading us towards collapse,” Greenpeace said, arguing that lifestyles fuelled by “the arrogance of a few billionaires” are devastating for the planet.
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: let
  homepage-config = import ./homepage.nix;
in {
  imports = [
    ./hardware-configuration.nix
    ../../nix-base.nix
    ../nixos-base.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  hardware = {
    sane = {
      enable = true;
      drivers = {
        scanSnap = {
          enable = true;
        };
      };
    };
  };

  networking = {
    hostName = "platini";
    domain = "mexico86.co.uk";
    useDHCP = false;
    interfaces.wlp3s0.useDHCP = true;

    networkmanager = {
      enable = true;
    };
    firewall = {
      allowedTCPPorts = [80 443 445 3400 3445 3500 3401 3405 4070 4444 8083 8384 22000 44831];
      allowedTCPPortRanges = [
        {
          from = 1400;
          to = 1410;
        }
      ];
      allowedUDPPorts = [2869 10243 5353 6969 35382 22000 21027];
      allowedUDPPortRanges = [
        {
          from = 136;
          to = 139;
        }
        {
          from = 1900;
          to = 1901;
        }
        {
          from = 10280;
          to = 10284;
        }
        {
          from = 40000;
          to = 60000;
        }
      ];
      checkReversePath = "loose";
    };
  };

  environment = {
    systemPackages = with pkgs; [
      chrysalis
      chromium
      noson
      xwayland-satellite
    ];
  };

  programs = {
    xwayland = {
      enable = true;
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };

  services = {
    printing = {
      enable = true;
      drivers = [pkgs.hplip];
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    udev.packages = [pkgs.chrysalis pkgs.chromium];

    udisks2 = {
      enable = true;
    };

    syncthing = {
      enable = true;
      user = "mryall";
      dataDir = "/home/mryall/";
      configDir = "/home/mryall/.config/syncthing/";
      guiAddress = "0.0.0.0:8384";
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
          disabledCollectors = ["textfile"];
          openFirewall = true;
          firewallFilter = "-i br0 -p tcp -m tcp --dport 9100";
        };
      };
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
