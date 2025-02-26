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

  # xdg = {
  #   enable = true;
  #   mime.enable = true;
  #   mimeApps.enable = true;
  # };

  imports = [
    ../modules/stylix.nix
    ../sef/git
    ../sef/1password
    ../sef/ssh
    ../sef/nvim
    ../sef/kitty
    ../sef/ghostty
    ../sef/zen
    ../sef/zellij
    ../sef/starship
    ../sef/zsh
    ../sef/dotnet
  ];

  home.sessionVariables = {
    MSBUILDTERMINALLOGGER = "true";
  };

  programs.zsh.envExtra = ''
    export PATH="$PATH:/usr/local/go/bin";
  '';

  home.packages = with pkgs; [
    flyctl
    zip
    tlrc
    noto-fonts
    noto-fonts-emoji
    nh
    inputs.zen.packages."${pkgs.system}".default
    pandoc
    (pkgs.writeShellApplication {
      name = "ghostty";
      text = ''
        nixGL ${(lib.getExe inputs.ghostty.packages.x86_64-linux.default)}
      '';
    })
  ];

  programs.zsh.shellAliases.http = "/home/sef/vintus/vhttp/zig-out/bin/vhttp";

  programs = {
    git.signing.signer = lib.mkForce "/opt/1Password/op-ssh-sign";
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

  xdg.desktopEntries.ghostty = {
    exec = "ghostty";
    name = "Ghostty";
    type = "Application";
    categories = [
      "System"
      "TerminalEmulator"
    ];
    icon = "/home/sef/Pictures/ghostty.png";
    terminal = false;
  };
}
