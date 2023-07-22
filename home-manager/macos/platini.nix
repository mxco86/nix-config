{ config, lib, pkgs, ... }:

{
  imports = [ ./personal.nix ];

  home-manager.users.mryall = { pkgs, ... }: {
    programs = {
      alacritty = {
        settings = {
          font = {
            size = 18;
          };
        };
      };
    };
  };
}
