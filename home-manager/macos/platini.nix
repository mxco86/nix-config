{ config, lib, pkgs, ... }:

{
  imports = [ ./personal.nix ];

  programs = {
    kitty = {
      enable = false;
    };
    tmux = {
      terminal = "xterm-256color";
    };
  };
}
