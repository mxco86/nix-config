{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports = [ ../base.nix ];

  home.packages = with pkgs; [ silver-searcher chroma slack ];

  programs = {
    zsh = { oh-my-zsh = { plugins = [ "osx" ]; }; };
    tmux = { shell = "${pkgs.zsh}/bin/zsh"; };
    kitty = {
      settings = {
        # Fonts
        font_size = 14;
      };
    };
    ssh = {
      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/id_rsa";
          identitiesOnly = true;
        };
      };
    };
    git = {
      extraConfig = {
        credential = { helper = "osxkeychain"; };
      };
    };
  };
}
