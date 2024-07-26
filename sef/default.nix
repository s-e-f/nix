{ pkgs, inputs, ... }:
{
  home = {
    username = "sef";
    homeDirectory = "/home/sef";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;

  nixpkgs.overlays = [ inputs.nur.overlay ];
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./git
    ./1password
    ./nvim
    ./kitty
    ./firefox
    ./hypr
    ./zellij
    ./starship
    ./zsh
  ];

  home = {
    packages = with pkgs; [
      flyctl
      zip
      tlrc
      surrealdb
      usql
    ];
  };

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    bat = {
      enable = true;
      themes.kanagawa = {
        src = pkgs.fetchFromGitHub {
          owner = "rebelot";
          repo = "kanagawa.nvim";
          rev = "e5f7b8a804360f0a48e40d0083a97193ee4fcc87";
          hash = "sha256-FnwqqF/jtCgfmjIIR70xx8kL5oAqonrbDEGNw0sixoA=";
        };
        file = "extras/kanagawa.tmTheme";
      };
      config.theme = "kanagawa";
    };
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
