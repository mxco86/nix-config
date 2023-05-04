{ pkgs, username, ... }:

{
  imports = [ ./work.nix ];

  home-manager.users.${username} = { pkgs, ... }: {
    programs = {
      kitty = {
        enable = true;
        settings = { font_size = 16; };
      };
    };
  };
}
