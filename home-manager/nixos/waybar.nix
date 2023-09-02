{ size, pkgs, ... }:

{
  position = "top";
  height = 30;
  modules-left = [
    "sway/workspaces"
    "sway/mode"
  ];
  modules-center = [
    "sway/window"
  ];
  modules-right = [
    "network"
    "backlight"
    "memory"
    "cpu"
    "pulseaudio"
    "battery"
    "clock"
  ];
  "cpu" = {
    format = "{usage}% ";
  };
  "memory" = {
    format = "{}% ";
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
  "pulseaudio" = {
    format = "{icon} {volume}%";
    format-bluetooth = "{icon} {volume}%";
    format-muted = " 0%";
    format-icons = {
      "headphones" = "";
      "handsfree" = "";
      "headset" = "";
      "phone" = "";
      "portable" = "";
      "car" = "";
      "default" = [ "" "" ];
    };
  };
}
