{ pkgs, inputs, ... }:
{
  services.hyprpaper.enable = true;
  services.hyprpaper.package = inputs.hyprpaper.packages.${pkgs.system}.default;
}
