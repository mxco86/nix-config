{ pkgs, username, ... }:

{
  imports = [ ../base.nix ];

  home-manager.users.${username} = { pkgs, ... }: {
    home = {
      packages = with pkgs; [
        chroma
        passff-host
      ];
    };

    programs = {
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
  };
}
