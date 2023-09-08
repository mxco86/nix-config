{ modules-right, height, ... }:

{
  position = "top";
  height = height;
  modules-left = [
    "sway/workspaces"
    "sway/mode"
  ];
  modules-center = [
    "sway/window"
  ];
  modules-right = modules-right;
  "cpu" = {
    format = "{usage}% ";
  };
  "memory" = {
    format = "{}% ";
  };
  "disk" = {
    format = "{percentage_used}/{total} ";
  };
  "backlight" = {
    "format" = "{percent}% {icon}";
    "states" = [ 0 50 ];
    "format-icons" = [ "" "" ];
  };
  "battery" = {
    "states" = {
      "good" = 95;
      "warning" = 30;
      "critical" = 15;
    };
    "format" = "{capacity}% {icon}";
    "format-icons" = [ "" "" "" "" "" ];
  };
  "network" = {
    "format-wifi" = "{essid} ({signalStrength}%) ";
    "format-ethernet" = "{ifname}: {ipaddr}/{cidr} ";
    "format-disconnected" = "Disconnected ⚠";
    "interval" = 7;
  };
  "wireplumber" = {
    format = "{icon} {volume}%";
    format-muted = " 0%";
    format-icons = {
      "headphones" = "";
      "default" = [ "" "" ];
    };
  };
}
