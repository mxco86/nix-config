# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix ../../nix-base.nix ../nixos-base.nix ];

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
      allowedTCPPorts = [ 8083 2080 8384 22000 44831 ];
      allowedUDPPorts = [ 22000 21027 ];
    };
  };

  environment = {
    systemPackages = [ pkgs.chrysalis pkgs.nfs-utils ];

    etc."ipsec.secrets".text = ''
      include ipsec.d/ipsec.nm-l2tp.secrets
    '';

    variables = {
      ROC_ENABLE_PRE_VEGA = "1";
    };
  };

  services = {
    udev.packages = [ pkgs.chrysalis ];
    udisks2 = { enable = true; };
    transmission = {
      enable = true;
      openFirewall = true;
    };
    syncthing = {
      enable = true;
      user = "mryall";
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
    prometheus = {
      exporters = {
        node = {
          enable = true;
          port = 9100;
          enabledCollectors = [
            "logind"
            "systemd"
          ];
          disabledCollectors = [
            "textfile"
          ];
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
