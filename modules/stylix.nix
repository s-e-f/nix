{ pkgs, inputs, ... }:
let
  # Based on solarflare
  colorSet = {
    base00 = "#1A2329";
    # 210 10% 13% (background)
    base01 = "#22292E";
    # 210 10% 17% (lighter background)
    base02 = "#3A4A54";
    # 210 15% 28% (selection background)
    base03 = "#4A5A63";
    # 210 14% 35% (comments/secondary content)
    base04 = "#74828C";
    # 210 15% 51% (dark foreground)
    base05 = "#A0A9B3";
    # 210 15% 69% (default foreground)
    base06 = "#CDD3D8";
    # 210 15% 82% (lighter foreground)
    base07 = "#E5E8EB";
    # 210 15% 91% (lightest foreground)
    base08 = "#E06A6B";
    # 0 65% 65%
    base09 = "#DC7A4A";
    # 30 60% 65%
    base0A = "#ffcc66";
    # 40 100% 70%
    base0B = "#bcc75c";
    # 66 49% 57%
    base0C = "#7bc1b8";
    # 172 36% 62%
    base0D = "#4599D8";
    # 210 60% 60%
    base0E = "#A675C8";
    # 285 50% 63%
    base0F = "#be97c4";
    # 292 28% 68%
  };
  removeHash = s: builtins.substring 1 (builtins.stringLength s - 1) s;
  theme = builtins.mapAttrs (_: v: removeHash v) colorSet;
in
{
  stylix = {
    enable = true;
    base16Scheme = theme;
    polarity = "dark";
    image = ../wallpapers/galaxy.jpg;
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
