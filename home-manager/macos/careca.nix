{ pkgs, username, ... }:

{
  imports = [ ./work.nix ];

  home-manager.users.${username} = { pkgs, ... }: {
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
