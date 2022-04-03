{ pkgs, ... }:

{
  imports = [ ./base.nix ];

  xresources = {
    properties = {
      "Xft.dpi" = 144;
      "Xft.antialias" = true;
      "Xft.rgba" = "rgb";
      "Xft.hinting" = true;
      "Xft.hintstyle" = "hintslight";
    };
  };

  programs = {
    firefox = {
      profiles = {
        mryall = {
          settings = {
            "layout.css.devPixelsPerPx" = "1";
            "font.size.systemFontScale" = "125";
          };
        };
      };
    };
  };
}
