{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports = [ ../base.nix ];

  home.packages = with pkgs; [ silver-searcher ];

  programs = { zsh = { oh-my-zsh = { plugins = [ "osx" ]; }; }; };
}
