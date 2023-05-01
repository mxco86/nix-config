{ config, lib, pkgs, ... }:

{
  imports = [ ./personal.nix ];

  home-manager.users.mryall = { pkgs, ... }: {
    programs = {
      kitty = {
        enable = false;
      };
      tmux = {
        terminal = "xterm-256color";
      };
    };
  };
}
