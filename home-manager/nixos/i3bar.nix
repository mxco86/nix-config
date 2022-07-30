{ size, pkgs, ... }:

{
  position = "top";
  statusCommand = "${pkgs.i3status}/bin/i3status";
  colors = {
    background = "#002b36";
    separator = "#657b83";
    statusline = "#fdf6e3";
    focusedWorkspace = {
      background = "#586e75";
      border = "#93a1a1";
      text = "#fdf6e3";
    };
    inactiveWorkspace = {
      background = "#002b36";
      border = "#073642";
      text = "#657b83";
    };
  };
  fonts = {
    names = [ "FontAwesome" "Hack" ];
    size = size;
  };
  extraConfig = ''
    separator_symbol 
  '';
}
