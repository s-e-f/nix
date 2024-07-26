{ pkgs, inputs, ... }:
let
  cursor = {
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePine-Linux";
    size = 26;
  };
in
{
  imports = [
    ./hyprland.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [ brightnessctl ];
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    cursorTheme = { } // cursor;
    theme = {
      package = pkgs.kanagawa-gtk-theme;
      name = "Kanagawa-BL";
    };
    iconTheme = {
      package = pkgs.kanagawa-icon-theme;
      name = "Kanagawa";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  home = {
    pointerCursor = {
      gtk.enable = true;
    } // cursor;
  };
}
