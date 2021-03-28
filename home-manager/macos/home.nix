{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports = [ ../base.nix ];

  home.packages = with pkgs; [ silver-searcher chroma slack ];

  programs = {
    zsh = { oh-my-zsh = { plugins = [ "osx" ]; }; };
    tmux = { shell = "${pkgs.zsh}/bin/zsh"; };
    kitty = {
      enable = true;
      font = {
        name = "Hack";
      };
      settings = {
        # Fonts
        font_size = 14;
        macos_thicken_font = "0.75";

        # Tabs
        tab_bar_style = "powerline";
        tab_bar_min_tabs = 1;

        # Config
        allow_remote_control = "yes";
        active_border_color = "#93a1a1";
        inactive_border_color = "#586e75";
        window_padding_width = 3;
        window_margin_width = 1;
        placement_strategy = "top-left";
        hide_window_decorations = "yes";

        # Color theme
        background = "#073642";
        foreground = "#93a1a1";
        cursor = "#586e75";
        selection_background = "#586e75";

        # Black
        color0 = "#073642";
        color8 = "#073642";

        # Red
        color1 = "#dc322f";
        color9 = "#cb4b16";

        # Green
        color2 = "#2aa198";
        color10 = "#2aa198";

        # Yellow
        color3 = "#b58900";
        color11 = "#859900";

        # Blue
        color4 = "#268bd2";
        color12 = "#6c71c4";

        # Magenta
        color5 = "#839496";
        color13 = "#93a1a1";

        # Cyan
        color6 = "#586e75";
        color14 = "#657b83";

        # White
        color7 = "#eee8d5";
        color15 = "#fdf6e3";
      };
    };
  };
}
