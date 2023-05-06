{ config, lib, pkgs, ... }:

{
  imports = [ ./personal.nix ];

  home-manager.users.mryall = { pkgs, ... }: {
    programs = {
      kitty = {
        enable = true;
        settings = {
          font_size = 16;
        };
      };
    };
  };
}
