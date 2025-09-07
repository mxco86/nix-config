# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: {
  imports = [./hardware-configuration.nix ../../nix-base.nix ../nixos-base.nix];

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/nvme0n1"; # or "nodev" for efi only
      };
    };
  };

  networking = {
    hostName = "sanchez";
    domain = "mexico86.co.uk";
    networkmanager = {
      enable = true;
    };
    useDHCP = false;
    interfaces.enp0s31f6.useDHCP = true;
    interfaces.wlp0s20f3.useDHCP = true;
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
  services = {
    syncthing = {
      enable = true;
      user = "mryall";
      dataDir = "/home/mryall/";
      configDir = "/home/mryall/.config/syncthing/";
      guiAddress = "0.0.0.0:8384";
    };
  };

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Packages
  environment = {
    systemPackages = with pkgs; [brightnessctl];

    etc."ipsec.secrets".text = ''
      include ipsec.d/ipsec.nm-l2tp.secrets
    '';
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}
