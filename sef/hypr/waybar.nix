{ pkgs, inputs, ... }:
{
  programs.waybar.enable = true;
  programs.waybar.settings.mainBar = {
    reload_style_on_change = true;
    layer = "top";
    position = "top";
    spacing = 15;
    modules-left = [
      "hyprland/workspaces"
      "hyprland/window"
    ];
    modules-center = [ ];
    modules-right = [
      "bluetooth"
      "pulseaudio"
      "network"
      "cpu"
      "memory"
      "temperature"
      "battery"
      "clock"
      "tray"
    ];
    "hyprland/workspaces" = {
      format = "{icon}";
      move-to-monitor = true;
      format-icons = {
        "terminal" = "<span face=\"Font Awesome 6 Free Solid\"> </span>";
        "browser" = "<span face=\"Font Awesome 6 Free Solid\"> </span>";
        "vault" = "<span face=\"Font Awesome 6 Free Solid\"> </span>";
        "default" = "<span face=\"Font Awesome 6 Free Solid\"> </span>";
      };
      persistent-workspaces = {
        "*" = 3;
      };
    };
    "hyprland/window" = {
      "format" = "{}";
      "rewrite" = { };
      "separate-outputs" = true;
    };
    bluetooth = {
      format = " {status}";
      format-connected = " {device_alias}";
      format-connected-battery = " {device_alias} {device_battery_percentage}%";
      #// "format-device-preference": [ "device1", "device2" ], // preference list deciding the displayed device
      tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
      tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
      tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
      tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
    };
    pulseaudio = {
      format = "{volume}% {icon}";
      format-bluetooth = "{volume}% {icon}";
      format-muted = "";
      format-icons = {
        "alsa_output.pci-0000_00_1f.3.analog-stereo" = "";
        "alsa_output.pci-0000_00_1f.3.analog-stereo-muted" = "";
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        phone-muted = "";
        portable = "";
        car = "";
        default = [
          ""
          ""
        ];
      };
      scroll-step = 1;
      on-click = "pavucontrol";
      ignored-sinks = [ "Easy Effects Sink" ];
    };
    tray = {
      spacing = 10;
    };
    clock = {
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = "{:%Y-%m-%d}";
    };
    cpu = {
      format = "{usage}% <span face=\"Font Awesome 6 Free\"> </span>";
      tooltip = false;
    };
    memory = {
      format = "{}%  ";
    };
    temperature = {
      critical-threshold = 80;
      format = "{temperatureC}°C";
      tooltip = false;
    };
    battery = {
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{capacity}% {icon}";
      format-full = "{capacity}% {icon}";
      format-charging = "{capacity}%  ";
      format-plugged = "{capacity}%  ";
      format-alt = "{time} {icon}";
      format-icons = [
        " "
        " "
        " "
        " "
        " "
      ];
    };
    network = {
      #// "interface": "wlp2*", // (Optional) To force the use of this interface
      format-wifi = "{essid} ({signalStrength}%)  ";
      format-ethernet = "{ipaddr}/{cidr}  ";
      tooltip-format = "{ifname} via {gwaddr}  ";
      format-linked = "{ifname} (No IP)  ";
      format-disconnected = "Disconnected  ";
      format-alt = "{ifname}: {ipaddr}/{cidr}";
    };
  };
  programs.waybar.style = ''
    * {
        border: none;
        border-radius: 0;
        font-family: Roboto, Helvetica, Arial, sans-serif;
        font-size: 13px;
        min-height: 0;
    }

    window#waybar {
        background-color: transparent;
        color: #c5c9c5;
    }
    window#waybar>box {
        background: rgba(24, 22, 22, 0.9);
        border-radius: 0px;
        padding: 6px;
        margin: 0px 0px 6px 0px;
        box-shadow: 0px 0px 2px 1px rgba(26, 26, 26, 238);
    }

    tooltip {
        background: rgba(43, 48, 59, 0.5);
        border: 1px solid rgba(100, 114, 125, 0.5);
    }
    tooltip label {
        color: #c5c9c5;
    }

    #workspaces button {
        padding: 0 5px;
        background: transparent;
        color: inherit;
    }

    #workspaces button.focused {
        background: #64727D;
        border-bottom: 3px solid white;
    }

    #workspaces button.active {
        color: #87a987;
    }

    @keyframes blink {
        to {
            background-color: #c5c9c5;
            color: #181616;
        }
    }

    #battery.warning:not(.charging) {
        background: #c4746e;
        color: #c5c9c5;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: steps(12);
        animation-iteration-count: infinite;
        animation-direction: alternate;
    }
  '';
}
