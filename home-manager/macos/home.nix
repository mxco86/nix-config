{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports = [ ../base.nix ];

  home.packages = with pkgs; [ silver-searcher chroma slack ];

  programs = {
    zsh = { oh-my-zsh = { plugins = [ "osx" ]; }; };
    tmux = { shell = "${pkgs.zsh}/bin/zsh"; };
  };
}
