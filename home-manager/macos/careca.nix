{ config, lib, pkgs, ... }:

{
  imports = [ ./work.nix ];

  programs = {
    kitty = {
      enable = true;
      settings = { font_size = 16; };
    };
  };
}
