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
    inputs.nur.overlay
    (final: prev: { zjstatus = inputs.zjstatus.packages.${prev.system}.default; })
  ];
  nixpkgs.config.allowUnfree = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  imports = [
    ./git
    ./1password
    #./nvim
    ./nixvim
    ./kitty
    (import ./firefox { inherit pkgs inputs username; })
    ./hypr
    ./zellij
    ./starship
    ./zsh
    # ./ags
    ./rofi
    ./discord
    ./stylix
  ];

  home = {
    packages = with pkgs; [
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
    ];
  };

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
