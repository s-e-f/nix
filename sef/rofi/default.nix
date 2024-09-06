{ pkgs, inputs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = with pkgs; [
      rofi-emoji-wayland
      (rofi-calc.override {
        rofi-unwrapped = rofi-wayland-unwrapped;
      })
    ];
    location = "center";
    theme = ./theme.rasi;
  };
}
