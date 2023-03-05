{ config, lib, pkgs, ... }:

{
  imports = [ ./personal.nix ];

  programs = {
    kitty = {
      settings = {
        font_size = 16;
      };
    };
  };
}
