{
  pkgs,
  inputs,
  username,
  ...
}:
{

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    general = {
      border_size = 0;
      gaps_in = 5;
      gaps_out = "7, 10, 10, 10";
    };

    group = {
      groupbar = {
        "col.active" = "0xff2d4f67";
        "col.inactive" = "0xff181618";
        font_size = 13;
        height = 20;
        render_titles = false;
      };
    };

    decoration = {
      rounding = 4;
      inactive_opacity = 0.7;
      blur = {
        enabled = true;
        size = 8;
        ignore_opacity = false;
        new_optimizations = true;
        xray = true;
        noise = 1.17e-2;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
        special = false;
        popups = false;
      };
    };

    gestures = {
      workspace_swipe = true;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
    };

    xwayland = {
      force_zero_scaling = true;
    };

    animations = {
      enabled = true;
      first_launch_animation = false;
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows, 1, 3.5, myBezier"
        "windowsOut, 1, 3.5, default, popin 80%"
        "border, 1, 5, default"
        "borderangle, 1, 4, default"
        "fade, 1, 3.5, default"
        "workspaces, 1, 3, default"
      ];
    };
    input = {
      sensitivity = -0.1;
      accel_profile = "flat";
    };
    cursor = {
      inactive_timeout = 5;
    };
    env = [
      "HYPRCURSOR_THEME,rose-pine-hyprcursor"
      "HYPRCURSOR_SIZE,26"
      "MOZ_ENABLE_WAYLAND,1"
    ];
    workspace = [
      "1, defaultName:terminal"
      "2, defaultName:browser"
      "3, defaultName:vault"
    ];
    monitor = [
      "desc:Huawei Technologies Co. Inc. MateView, highres@highrr, auto, 1.6"
      "desc:LG Electronics LG HDR WQHD 111NTTQA0897, 3440x1440@84.98, auto, 1"
      "desc:Lenovo Group Limited L32p-30 U511L2F2, highres@highrr, auto, 1.5"
      "desc:Lenovo Group Limited L32p-30 U512058T, highres@highrr, auto, 1.5"
      ", highres@highrr, auto, 1"
    ];
    windowrulev2 = [
      "workspace name:browser, class:(firefox)"
      "group set, class:(firefox)"
      "workspace name:terminal, class:(kitty)"
      "workspace name:vault, class:(1Password)"
    ];
    bind = [
      "SUPER, Q, killactive"
      "SUPER, F, fullscreen"
      "SUPER, M, exit"
      "SUPER, T, focusworkspaceoncurrentmonitor, name:terminal"
      "SUPER, T, exec, pidof kitty || kitty"
      "SUPER, B, focusworkspaceoncurrentmonitor, name:browser"
      "SUPER_ALT, 1, exec, firefox -P ${username}"
      "SUPER_ALT, 2, exec, firefox -P boyawave"
      "SUPER_ALT, 3, exec, firefox -P vintus"
      "SUPER_ALT, 4, exec, firefox -P ns"
      "SUPER_ALT, 5, exec, firefox -P bakker"
      "SUPER, P, focusworkspaceoncurrentmonitor, name:vault"
      "SUPER, P, exec, pidof 1password || 1password"
      "SUPER, ESCAPE, exec, pidof hyprlock || hyprlock --immediate"
      "SUPER, H, movefocus, l"
      "SUPER, L, movefocus, r"
      "SUPER, J, movefocus, d"
      "SUPER, K, movefocus, u"
    ];
    bindm = [ "SUPER, mouse:272, movewindow" ];
    bindle = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 0.01+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.01-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl set 1%+"
      ",XF86MonBrightnessDown, exec, brightnessctl set 1%-"
    ];
    exec-once = [
      "hypridle"
      "hyprpaper"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphis store"
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    ];
  };
}
