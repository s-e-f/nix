{ pkgs, ... }:
let
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEWzfajaOsrjRi9VBZ1eZHndHr/8HoIZT6szzySUVHAF";
  email = "39380372+s-e-f@users.noreply.github.com";
in
{
  home = {
    username = "sef";
    homeDirectory = "/home/sef";
    packages = with pkgs; [
      neofetch
      turso-cli
      sqld
      nix-prefetch-github
      dos2unix
      flyctl
      zip
      tlrc
      erlang
      rebar3
      surrealdb
      usql
      lua-language-server
      nil
      zig # Used as the c compiler for neovim
      tree-sitter

      # Required to compile fzf-native for nvim
      gnumake
      gcc

      # SQL Server
      sqlcmd
    ];
    sessionVariables = {
      EDITOR = "nvim";
      MSBUILDTERMINALLOGGER = "auto";
      NIL_PATH = "${pkgs.nil}/bin/nil";
    };
    file.".config/zellij/config.kdl".text = builtins.readFile ./zellij/config.kdl;
    file.".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };

  programs = {
    home-manager.enable = true;
    ssh = {
      enable = true;
      matchBlocks."*" = {
        extraOptions = {
          IdentityAgent = "~/.1password/agent.sock";
        };
      };
    };
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
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
    git = {
      enable = true;
      lfs.enable = true;
      userEmail = email;
      userName = "Sef";
      delta = {
        enable = true;
        options = {
          features = "kanagawa";
          "side-by-side" = true;
        };
      };
      extraConfig = {
        core.sshCommand = "ssh";
        commit.gpgsign = true;
        diff.colorMoved = "default";
        gpg = {
          format = "ssh";
          ssh.allowedSignersFile = "~/.ssh/allowed_signers";
          ssh.program = "${pkgs._1password-gui}/bin/op-ssh-sign";
        };
        init.defaultBranch = "main";
        log.showSignature = true;
        merge.conflictstyle = "diff3";
        tag.gpgsign = true;
        user.signingkey = public_key;
        status = {
          showUntrackedFiles = "all";
          relativePaths = false;
        };
        delta.syntax-theme = "kanagawa";
      };
      aliases = {
        st = "status -sb";
        prbi = "pull --rebase=interactive";
        prb = "pull --rebase";
      };
    };
    fd.enable = true;
    awscli = {
      enable = true;
    };
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
      };
      enableCompletion = true;
      enableVteIntegration = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initExtra = ''
        export PATH="$PATH:/home/sef/.cargo/bin"
      '';
      shellAliases = {
        npg = "nix-prefetch-github --nix";
        cat = "bat";
        cd = "z";
        v = "nvim";
        vi = "nvim";
        vim = "nvim";
      };
    };
    zellij = {
      enable = true;
      enableZshIntegration = true;
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        format = " $character";
        right_format = "$all";
        character.success_symbol = "[](bold green)";
        character.error_symbol = "[](bold red)";
      };
    };
  };

  home.stateVersion = "23.11";
}
