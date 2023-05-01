{ config, lib, pkgs, ... }:

{
  imports = [ ./personal.nix ];

  home-manager.users.mryall = { pkgs, ... }: {
    programs = {
      kitty = {
        settings = {
          font_size = 16;
        };
      };
    };
  };
}
