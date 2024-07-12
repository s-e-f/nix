{ pkgs
, ...
}:
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
      themes = {
        cyberdream = {
          src = pkgs.fetchFromGitHub {
            owner = "scottmckendry";
            repo = "cyberdream.nvim";
            rev = "90150e2966ddbe9f74465960efde4ee5dba6d9a4";
            hash = "sha256-l0MOiwcdKYN/0vzYa5rQ39Q+6uh9ecbV2TJpXivVoEs=";
          };
          file = "extras/textmate/cyberdream.tmTheme";
        };
      };
      config = {
        theme = "cyberdream";
      };
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
          features = "cyberdream";
          "side-by-side" = true;
        };
      };
      extraConfig = {
        core.sshCommand = "ssh.exe";
        commit.gpgsign = true;
        diff.colorMoved = "default";
        gpg = {
          format = "ssh";
          ssh.allowedSignersFile = "~/.ssh/allowed_signers";
          ssh.program = "op-ssh-sign-wsl";
        };
        init.defaultBranch = "main";
        include.path = "/home/sef/themes/cyberdream.nvim/extras/cyberdream.gitconfig";
        log.showSignature = true;
        merge.conflictstyle = "diff3";
        tag.gpgsign = true;
        user.signingkey = public_key;
        status = {
          showUntrackedFiles = "all";
          relativePaths = false;
        };
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
