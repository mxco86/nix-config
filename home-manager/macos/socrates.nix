{
  pkgs,
  username,
  ...
}: {
  imports = [./personal.nix];

  home-manager.users.${username} = {pkgs, ...}: {
    programs = {
      alacritty = {
        settings = {
          font = {
            size = 16;
          };
        };
      };
    };
  };
}
