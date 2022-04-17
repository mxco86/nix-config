{ config, lib, pkgs, ... }:

{
  imports = [ ../base.nix ];

  home.packages = with pkgs; [ silver-searcher chroma ];

  programs = {
    zsh = { oh-my-zsh = { plugins = [ "macos" ]; }; };
    kitty = {
      settings = {
        font_size = 14;
      };
    };
    git = {
      extraConfig = {
        credential = { helper = "osxkeychain"; };
      };
    };
    firefox = {
      package = pkgs.runCommand "firefox-0.0.0" { } "mkdir $out";
      profiles = {
        mryall = {
          userChrome = ''
            #TabsToolbar { visibility: collapse !important; }

            #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
                display:none;
            }
          '';
        };
      };
    };
  };
}
