{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./personal.nix];

  home-manager.users.mryall = {...}: {
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
