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
    ./1password
    ./mako
    ./nixvim
    ./kitty
    ./zen
    ./hypr
    ./zellij
    ./starship
    ./zsh
    ./nushell
    ./rofi
    ./discord
    ../modules/stylix.nix
  ];

  home.packages = with pkgs; [
    flyctl
    zip
    tlrc
    usql
    obsidian
    noto-fonts
    turso-cli
    nh
    nil
    nixfmt-rfc-style
    vscode-langservers-extracted
    jdt-language-server
    google-java-format
    lombok
    nodejs_22
    sqlcmd
    texlive.combined.scheme-full
    pandoc
    surrealdb
    surrealist
    inotify-tools
  ];

  programs = {
    git.extraConfig.gpg.ssh.program = lib.getExe' pkgs._1password-gui "op-ssh-sign";
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
