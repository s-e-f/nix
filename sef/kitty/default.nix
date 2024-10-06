{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [ kitty ];
  home.file.".config/kitty/kitty.conf".text = ''
    include ${inputs.kanagawa}/extras/kanagawa_dragon.conf
    background_opacity 0.9
    font_family FiraCode Nerd Font Mono
    bold_font auto
    italic_font auto
    bold_italic_font auto
    confirm_os_window_close 0
  '';
}
