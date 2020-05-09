{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports = [
    ../base.nix
  ];

  home.packages = with pkgs; [
    silver-searcher
  ];

}
