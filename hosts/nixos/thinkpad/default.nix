# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix ../../nix-base.nix ../nixos-base.nix ];

  boot = {
    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "/dev/nvme0n1"; # or "nodev" for efi only
      };
    };
  };

  networking.hostName = "sanchez";
  networking.domain = "mexico86.co.uk";
  networking.networkmanager = {
    enable = true;
    enableStrongSwan = true;
  };

  networking = {
    useDHCP = false;
    interfaces.enp0s31f6.useDHCP = true;
    interfaces.wlp0s20f3.useDHCP = true;
  };

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  services = {
    dbus.packages = with pkgs; [ gnome3.dconf ];
    xserver = {
      enable = true;
      layout = "us";
      autorun = true;
      dpi = 210;

      libinput = {
        enable = true;
        clickMethod = "clickfinger";
        disableWhileTyping = true;
        naturalScrolling = false;
        scrollMethod = "twofinger";
        tapping = false;
        tappingDragLock = false;
      };

      synaptics = {
        enable = false;
      };
    };

    actkbd = {
      enable = true;
      bindings = [
        { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/brightnessctl s 10%-"; }
        { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/brightnessctl s +10%"; }
      ];
    };
  };

  sound = {
    enable = true;
  };

  hardware = {
    pulseaudio.enable = true;
  };

  # Packages
  environment = {
    systemPackages = with pkgs;
      [ brightnessctl ];

    etc."ipsec.secrets".text = ''
      include ipsec.d/ipsec.nm-l2tp.secrets
    '';
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}
