{
  pkgs,
  config,
  inputs,
  ...
}:
{
  stylix = {
    enable = true;
    base16Scheme = import ./colors.nix;
    polarity = "dark";
    image = ../hypr/wallpapers/koi.jpg;
    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 26;
    };
    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };

      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };

      monospace = {
        package = (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; });
        name = "FiraCode Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
    opacity = {
      terminal = 0.8;
      desktop = 0.8;
    };
  };
}
