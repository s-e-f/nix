{ pkgs, inputs, ... }:
{
  programs.waybar.enable = true;
  programs.waybar.systemd.enable = true; # nh switch fails to properly restart waybar
  programs.waybar.settings.mainBar = {
    reload_style_on_change = true;
    layer = "top";
    position = "top";
    spacing = 20;
    modules-left = [
      "hyprland/workspaces"
      "hyprland/window"
    ];
    modules-center = [ ];
    modules-right = [
      "tray"
      "pulseaudio"
      "network"
      "cpu"
      "memory"
      "temperature"
      "battery"
      "clock"
    ];
    "hyprland/workspaces" = {
      format = "{icon}";
      move-to-monitor = true;
      format-icons = {
        terminal = " ";
        browser = " ";
        vault = " ";
        obsidian = " ";
        discord = " ";
        steam = " ";
        default = " ";
      };
      persistent-workspaces =
        {
        };
    };
    "hyprland/window" = {
      format = "{}";
      rewrite = {
        "(.*) — Mozilla Firefox" = "  $1";
      };
      separate-outputs = true;
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
      format = "{icon} {volume}%";
      format-bluetooth = "{icon} {volume}%";
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
      format = "<span face=\"Font Awesome 6 Free\"> </span> {usage}%";
      tooltip = false;
    };
    memory = {
      format = "  {}%";
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
      format = "{icon} {capacity}%";
      format-full = "{icon} {capacity}%";
      format-charging = " {capacity}%";
      format-plugged = " {capacity}%";
      format-alt = "{icon} {time}";
      format-icons = [
        " "
        " "
        " "
        " "
        " "
      ];
    };
    network = {
      format-wifi = " {essid} ({signalStrength}%)";
      format-ethernet = "  {ipaddr}/{cidr}";
      tooltip-format = "  {ifname} via {gwaddr}";
      format-linked = "  {ifname} (No IP)";
      format-disconnected = " Disconnected";
      format-alt = "{ifname}: {ipaddr}/{cidr}";
    };
  };
  programs.waybar.style = ''
    * {
        border: none;
        border-radius: 0;
        font-family: 'Noto Sans', 'Font Awesome 6 Free', 'Font Awesome 6 Brands', Roboto, Helvetica, Arial, sans-serif;
        font-weight: bold;
        font-size: 14px;
        min-height: 0;
    }

    window#waybar {
        background-color: transparent;
        color: #c5c9c5;
    }
    window#waybar>box {
        background: rgba(24, 22, 22, 0.8);
        border-radius: 0px;
        padding: 10px;
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
