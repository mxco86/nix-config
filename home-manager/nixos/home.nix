{ pkgs, ... }:

{
  imports = [ ../base.nix ];

  home = {
    packages = with pkgs; [
      anki
      discord
      firefox
      keepassxc
      slack
      nix-linter
      xclip
      xorg.xdpyinfo
      xorg.xmodmap
      zoom-us
      jetbrains.idea-community
    ];

    keyboard = { options = [ "ctrl:nocaps" ]; };
  };

  programs.urxvt = { enable = true; };

  services.syncthing = { enable = true; };

  xresources.extraConfig =
    builtins.readFile ~/Config/system-config/thinkpad-x1/X/.Xresources;

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod5";
      bars = [ ];
    };
    extraConfig =
      builtins.readFile ~/Config/system-config/thinkpad-x1/i3/config;
  };
}
