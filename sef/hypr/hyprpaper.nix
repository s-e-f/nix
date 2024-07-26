{ pkgs, inputs, ... }:
{
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    preload = "${./wallpapers/kanagawa-dark.jpeg}";
    wallpaper = ",${./wallpapers/kanagawa-dark.jpeg}";
  };
}
