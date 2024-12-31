{ inputs, ... }:
{
  home.packages = [
    inputs.ghostty.packages.x86_64-linux.default
  ];

  home.file.".config/ghostty/config".text = ''
    background-opacity = 0.9
    background-blur-radius = 20

    font-family = FiraCode Nerd Font Mono
    window-decoration = false
    confirm-close-surface = false

    adjust-cell-height = 35%
    adjust-cursor-height = 35%
    font-size = 11
  '';
}
