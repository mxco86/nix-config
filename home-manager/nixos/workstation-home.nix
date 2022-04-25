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
    i3status = {
      enable = true;
      enableDefault = false;
      general = {
        colors = true;
        color_good = "#6c71c4";
        color_degraded = "#b58900";
        color_bad = "#dc322f";
        color_separator = "#657b83";
        interval = 5;
      };
      modules = {
        ipv6 = {
          position = 1;
        };
        load = {
          position = 2;
        };
        memory = {
          position = 3;
        };
        "tztime local" = {
          position = 4;
        };
      };
    };

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
