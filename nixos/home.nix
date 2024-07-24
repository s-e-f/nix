{ pkgs, inputs, ... }:
let
  cursor = {
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePine-Linux";
    size = 26;
  };
in
{
  imports = [ ./../core/home.nix ];

  programs = {
    alacritty = {
      enable = true;
      settings = {
        import = [ "${inputs.kanagawa}/extras/alacritty_kanagawa_dragon.toml" ];
        window.opacity = 0.9;
        env = {
          TERM = "xterm-256color";
        };
        font =
          let
            fontFamily = "FiraCode Nerd Font";
          in
          {
            normal = {
              family = "${fontFamily}";
              style = "Regular";
            };
            bold = {
              family = "${fontFamily}";
              style = "Bold";
            };
            italic = {
              family = "${fontFamily}";
              style = "Italic";
            };
            bold_italic = {
              family = "${fontFamily}";
              style = "Bold Italic";
            };
            size = 12.0;
          };
      };
    };
    firefox.enable = true;
  };

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
      name = "oomox-Kanagawa";
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

  home.file.".config/1Password/ssh/agent.toml".text = ''
    [[ssh-keys]]
    vault = "Private"

    [[ssh-keys]]
    vault = "NS"
  '';

  home.file.".config/hypr" = {
    source = ./hypr;
    recursive = true;
  };

  home.file.".config/waybar" = {
    source = ./waybar;
    recursive = true;
  };
}
