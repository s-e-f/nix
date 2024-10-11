{
  pkgs,
  config,
  inputs,
  ...
}:
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
        terminal = "";
        browser = "";
        vault = "";
        obsidian = "";
        discord = "";
        steam = "";
        default = "";
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
  stylix.targets.waybar.enable = false;
  programs.waybar.style = with config.lib.stylix.colors.withHashtag; ''
    @define-color base00 ${base00};
    @define-color base01 ${base01};
    @define-color base02 ${base02};
    @define-color base03 ${base03};
    @define-color base04 ${base04};
    @define-color base05 ${base05};
    @define-color base06 ${base06};
    @define-color base07 ${base07};
    @define-color base08 ${base08};
    @define-color base09 ${base09};
    @define-color base0A ${base0A};
    @define-color base0B ${base0B};
    @define-color base0C ${base0C};
    @define-color base0D ${base0D};
    @define-color base0E ${base0E};
    @define-color base0F ${base0F};
    * {
      border: none;
      border-radius: 0;
      font-family: 'Noto Sans', 'Font Awesome 6 Free', 'Font Awesome 6 Brands', Roboto, Helvetica, Arial, sans-serif;
      font-weight: bold;
      font-size: 14px;
      min-height: 0;
    }

    window#waybar, tooltip {
      background: alpha(@base00, ${with config.stylix.opacity; builtins.toString desktop});
      color: @base05;
    }

    window#waybar>box {
      border-radius: 0px;
      padding: 10px;
    }

    .modules-left #workspaces button {
      padding: 0 5px;
      background: transparent;
      color: inherit;
    }

    #workspaces button.active {
      color: @accent_color;
    }

    @keyframes blink {
      to {
        background-color: @base06;
        color: @base01;
      }
    }

    #battery.warning:not(.charging) {
      background: @base08;
      color: @base06;
      animation-name: blink;
      animation-duration: 0.5s;
      animation-timing-function: steps(12);
      animation-iteration-count: infinite;
      animation-direction: alternate;
    }
  '';
}
