{ config, lib, pkgs, ... }:

{
  imports = [ ../base.nix ];

  home.packages = with pkgs; [ silver-searcher chroma slack ];

  programs = {
    zsh = { oh-my-zsh = { plugins = [ "osx" ]; }; };
    kitty = {
      settings = {
        font_size = 14;
      };
    };
    git = {
      extraConfig = {
        credential = { helper = "osxkeychain"; };
      };
    };
  };
}
