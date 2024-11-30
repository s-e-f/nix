{ pkgs, inputs, ... }:
let
  # Based on solarflare
  colorSet = {
    base00 = "#18262F";
    base01 = "#222E38";
    base02 = "#586875";
    base03 = "#667581";
    base04 = "#85939E";
    base05 = "#A6AFB8";
    base06 = "#E8E9ED";
    base07 = "#F5F7FA";
    base08 = "#EF5253";
    base09 = "#E66B2B";
    base0A = "#E4B51C";
    base0B = "#7CC844";
    base0C = "#52CBB0";
    base0D = "#33B5E1";
    base0E = "#A363D5";
    base0F = "#D73C9A";
  };
  removeHash = s: builtins.substring 1 (builtins.stringLength s - 1) s;
  theme = builtins.mapAttrs (_: v: removeHash v) colorSet;
in
{
  stylix = {
    enable = true;
    base16Scheme = theme;
    polarity = "dark";
    image = ../wallpapers/koi.jpg;
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
        package = pkgs.nerd-fonts.fira-code;
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
