{
  pkgs,
  inputs,
  lib,
  ...
}:
let
  username = "sef";
in
{
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;

  nixpkgs.overlays = [
    inputs.nur.overlays.default
    (final: prev: { zjstatus = inputs.zjstatus.packages.${prev.system}.default; })
  ];
  nixpkgs.config.allowUnfree = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps.enable = true;
  };

  stylix = {
    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      light = "Papirus-Light";
      dark = "Papirus-Dark";
    };
  };

  imports = [
    ./git
    ./ssh
    # ./1password
    ./dotnet
    ./mako
    ./nvim
    ./kitty
    ./ghostty
    ./zen
    ./hypr
    ./starship
    ./zsh
    ./nushell
    ./rofi
    ./discord
    ../modules/stylix.nix
  ];

  home.file.".config/electron-flags.conf".text = ''
    --ozone-platform=wayland
    --enable-features=UseOzonePlatform,WaylandWindowDecorations
  '';

  home.packages = with pkgs; [
    flyctl
    zip
    unzip
    tlrc
    obsidian
    noto-fonts
    aseprite
    nh
    nil
    nixfmt-rfc-style
    vscode-langservers-extracted
    inotify-tools
    hyprshot
    inputs.ghostty.packages.x86_64-linux.default
    prismlauncher
    proton-pass
    protonmail-desktop
    brave
  ];

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    bat.enable = true;
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    ripgrep.enable = true;
    zoxide = {
      enable = true;
      options = [

      ];
    };
    jq.enable = true;
    btop.enable = true;
    eza = {
      enable = true;
      extraOptions = [
        "-l"
        "--icons"
        "--no-permissions"
        "--no-time"
        "--smart-group"
        "-a"
        "--git"
      ];
    };
    fd.enable = true;
  };

}
