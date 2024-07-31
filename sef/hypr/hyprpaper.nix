{ pkgs, inputs, ... }:
{
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    preload = "${./wallpapers/koi.jpg}";
    wallpaper = ",${./wallpapers/koi.jpg}";
  };
}
