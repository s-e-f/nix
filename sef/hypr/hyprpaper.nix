{ pkgs, inputs, ... }:
{
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    preload = "${./wallpapers/koi.jpeg}";
    wallpaper = ",${./wallpapers/koi.jpeg}";
  };
}
