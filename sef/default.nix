{
  pkgs,
  inputs,
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
    ./nvim
    ./kitty
    (import ./firefox { inherit pkgs inputs username; })
    (import ./hypr { inherit pkgs inputs username; })
    ./zellij
    ./starship
    ./zsh
    # ./ags
    ./rofi
    ./discord
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
    sessionVariables = {
      JDTLS_JVM_ARGS = "-javaagent:${pkgs.lombok}/share/java/lombok.jar";
    };
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
