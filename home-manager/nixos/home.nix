{ config, lib, pkgs, ... }:

{
  imports = [
    ../base.nix
  ];

  home.packages = with pkgs; [
    anki
    discord
    firefox
    keepassxc
    slack
    mu
    xorg.xdpyinfo
    xorg.xmodmap
    zoom-us
    jetbrains.idea-community
  ];

  xresources.extraConfig = builtins.readFile ~/Config/system-config/thinkpad-x1/X/.Xresources;

  home.keyboard = {
    options = [ "ctrl:nocaps" ];
  };

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod5";
      bars = [];
    };
    extraConfig = builtins.readFile ~/Config/system-config/thinkpad-x1/i3/config;
  };

  programs.urxvt = {
    enable = true;
  };
}
