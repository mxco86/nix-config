{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./personal.nix];

  home-manager.users.mryall = {...}: {
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
