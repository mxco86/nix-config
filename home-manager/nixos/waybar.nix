{
  modules-right,
  height,
  ...
}: {
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
  "clock" = {
    "tooltip-format" = "<tt><small>{calendar}</small></tt>";
    "calendar" = {
      format = {"today" = "<span><b><u>{}</u></b></span>";};
    };
  };
  "cpu" = {
    format = "{usage}% ";
  };
  "memory" = {
    format = "{}% ";
    tooltip-format = ''
      Main: {used:0.1f}GiB / {total:0.1f}GiB
      Swap: {swapUsed:0.1f}GiB / {swapTotal:0.1f}GiB'';
  };
  "disk" = {
    format = "{used}/{total} ";
  };
  "backlight" = {
    "format" = "{percent}% {icon}";
    "states" = [0 50];
    "format-icons" = ["" ""];
  };
  "battery" = {
    "states" = {
      "good" = 95;
      "warning" = 30;
      "critical" = 15;
    };
    "format" = "{capacity}% {icon}";
    "format-icons" = ["" "" "" "" ""];
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
      "default" = ["" ""];
    };
  };
}
