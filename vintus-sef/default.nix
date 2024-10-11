{ pkgs, inputs, ... }:
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
    ../modules/stylix.nix
    ../sef/git
    ../sef/1password
    #./nvim
    ../sef/nixvim
    ../sef/kitty
    (import ../sef/firefox { inherit pkgs inputs username; })
    #./hypr
    ../sef/zellij
    ../sef/starship
    ../sef/zsh
    # ./ags
    #./rofi
    #./discord
  ];

  home.packages = with pkgs; [
    flyctl
    zip
    tlrc
    usql
    obsidian
    noto-fonts
    noto-fonts-emoji
    turso-cli
    nh
    nil
    nixfmt-rfc-style
    vscode-langservers-extracted
    google-java-format
    nodejs_22
    sqlcmd
  ];

  programs = {
    git.extraConfig.gpg.ssh.program = "/opt/1Password/op-ssh-sign";
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

  stylix = {
    autoEnable = false;
    targets = {
      bat.enable = true;
      fzf.enable = true;
      kitty.enable = true;
      nixvim.enable = true;
      nixvim.transparentBackground.main = true;
      nixvim.transparentBackground.signColumn = true;
    };
  };
}
