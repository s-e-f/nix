{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  # shadow options have changed and stylix has not yet caught up
  stylix.targets.hyprland.enable = false;
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    settings = {
      general = {
        border_size = 0;
        gaps_in = 5;
        gaps_out = 10;
      };

      group = {
        groupbar = {
          font_size = 13;
          height = 20;
          render_titles = false;
        };
      };

      decoration = {
        rounding = 4;
        inactive_opacity = 0.7;
        shadow = {
          enabled = false;
        };
        blur = {
          enabled = true;
          size = 10;
          passes = 3;
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
          "windows, 1, 1.75, myBezier"
          "windowsOut, 1, 1.75, myBezier, popin 80%"
          "border, 1, 1.75, myBezier"
          "borderangle, 1, 1.75, myBezier"
          "fade, 1, 3.5, myBezier"
          "workspaces, 1, 1.75, myBezier"
        ];
      };

      layerrule = [ "blur,waybar" ];

      input = {
        sensitivity = -0.1;
        accel_profile = "flat";
      };
      cursor = {
        no_hardware_cursors = true;
        inactive_timeout = 5;
      };
      env = [
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
        "HYPRCURSOR_SIZE,26"
        "MOZ_ENABLE_WAYLAND,1"
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];
      monitor = [
        "desc:HP Inc. HP E24mv G4 CNC21806N9, highres@highrr, 0x0, 1"
        "desc:HP Inc. HP E24 G4 CN42290TQG, highres@highrr, 1920x0, 1"
        "desc:Huawei Technologies Co. Inc. MateView, highres@highrr, auto, 1.6"
        "desc:LG Electronics LG HDR WQHD 111NTTQA0897, 3440x1440@84.98, auto, 1"
        "desc:Lenovo Group Limited L32p-30 U511L2F2, highres@highrr, auto, 1.5"
        "desc:Lenovo Group Limited L32p-30 U512058T, highres@highrr, auto, 1.5"
        ", highres@highrr, auto, 1"
      ];
      workspace = [
        "1, defaultName:terminal"
        "2, defaultName:browser"
        "3, defaultName:obsidian"
        "4, defaultName:vault"
        "5, defaultName:discord"
        "6, defaultName:steam"
      ];
      bind =
        let
          ensure = pkgs.writeShellApplication {
            name = "ensure_and_focus";
            text = ''
              hyprctl clients -j | jq -c -e ".[] | select(.class==\"$1\") | .pid" || $2
            '';
          };
        in
        [
          "SUPER, Q, killactive"
          "SUPER, F, fullscreen"
          "SUPER, M, exit"
          "SUPER, T, focusworkspaceoncurrentmonitor, name:terminal"
          "SUPER, T, exec, [workspace name:terminal] ${lib.getExe ensure} com.mitchellh.ghostty ghostty"
          "SUPER, B, focusworkspaceoncurrentmonitor, name:browser"
          "SUPER, B, exec, [workspace name:browser] ${lib.getExe ensure} zen zen"
          "SUPER, O, focusworkspaceoncurrentmonitor, name:obsidian"
          "SUPER, O, exec, [workspace name:obsidian] ${lib.getExe ensure} obsidian obsidian"
          "SUPER, P, focusworkspaceoncurrentmonitor, name:vault"
          "SUPER, P, exec, [workspace name:vault] ${lib.getExe ensure} 1Password 1password"
          "SUPER, D, focusworkspaceoncurrentmonitor, name:discord"
          "SUPER, D, exec, [workspace name:discord] ${lib.getExe ensure} discord discordcanary"
          "SUPER, S, focusworkspaceoncurrentmonitor, name:steam"
          "SUPER, S, exec, [workspace name:steam] ${lib.getExe ensure} steam steam"
          "SUPER, E, exec, thunar"
          "SUPER, ESCAPE, exec, pidof hyprlock || hyprlock --immediate"
          "SUPER, code:60, exec, rofi -modes emoji -show emoji"
          "SUPER, C, exec, rofi -show calc -modi calc -no-show-match -no-sort -no-history -calc-command '${pkgs.wtype}/bin/wtype \"{result}\"'"
          "SUPER, R, exec, rofi -show drun"
          "SUPER, H, movefocus, l"
          "SUPER, L, movefocus, r"
          "SUPER, J, movefocus, d"
          "SUPER, K, movefocus, u"
          "CONTROL_L SUPER, P, exec, hyprshot -m region --clipboard-only"
          "CONTROL_L SUPER, C, exec, ${pkgs.lib.getExe pkgs.hyprpicker} -a --format=hsl"
        ];
      bindm = [ "SUPER, mouse:272, movewindow" ];
      bindle = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 0.01+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.01-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl set 1%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 1%-"
      ];
      exec = [ "export HYPRLAND_INSTANCE_SIGNATURE=$(hyprctl instances -j | jq '.[0].instance' -r)" ];
      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "hypridle"
        "hyprpaper"
        # (lib.getExe pkgs.clipboard-jh)
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "[workspace name:vault silent] 1password"
      ];
    };
  };
}
