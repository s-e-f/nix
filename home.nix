{
  config,
  pkgs,
  args,
  ...
}: let
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPrpRHuSQiGmjn1pn9KyyoGaRxAdLisUQ0BJZHi8TRaT";
  email = "39380372+s-e-f@users.noreply.github.com";
in {
  imports = [
    args.nixvim.homeManagerModules.nixvim
  ];

  home = {
    username = "sef";
    homeDirectory = "/home/sef";
    packages = with pkgs; [
      socat
      neofetch
      ripgrep
      fzf
      jq
      alejandra
      btop
      rustup
      surrealdb
      nodejs_21
      eza
      nix-prefetch-github
    ];
    file.".ssh/allowed_signers".text = ''
      ${email} ${public_key}
    '';
  };

  programs = {
    home-manager.enable = true;
    bat = {
      enable = true;
      themes = {
        catppuccin-mocha = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "b8134f01b0ac176f1cf2a7043a5abf5a1a29457b";
            sha256 = "sha256-gzf0/Ltw8mGMsEFBTUuN33MSFtUP4xhdxfoZFntaycQ=";
          };
          file = "themes/Catppuccin Mocha.tmTheme";
        };
      };
      config = {
        theme = "catppuccin-mocha";
      };
    };
    git = {
      enable = true;
      userEmail = email;
      userName = "Sef";
      extraConfig = {
        gpg = {
			format = "ssh";
			ssh.allowedSignersFile = "~/.ssh/allowed_signers";
			ssh.program = "/mnt/c/Users/SeverinFitriyadi/AppData/Local/1Password/app/8/op-ssh-sign-wsl";
		};
        user.signingkey = public_key;
        commit.gpgsign = true;
        tag.gpgsign = true;
        log.showSignature = true;
      };
      aliases = {
        st = "status -sb";
      };
    };
    go.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        l = "eza -l --icons --no-permissions --no-time --smart-group -a --git --total-size";
        ls = "eza";
        npg = "nix-prefetch-github --nix";
        cat = "bat";
        nix-format = "alejandra *.nix";
      };
    };
    zellij = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        theme = "catppuccin-mocha";
      };
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
    nixvim = {
      enable = true;
      colorschemes.catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
          transparent_background = true;
        };
      };
      globals = {
        mapleader = " ";
      };
      opts = {
        number = true;
        relativenumber = true;
        updatetime = 100;
        fileencoding = "utf-8";
        scrolloff = 10;
        signcolumn = "yes";
        ignorecase = true;
        smartcase = true;
        tabstop = 4;
        shiftwidth = 4;
        softtabstop = 4;
        smartindent = true;
        autoindent = true;
        smarttab = true;
        cindent = true;
        cinkeys = "0{,0},0),0],:,!^F,o,O,e";
        list = true;
        listchars = "lead:.,trail:+,tab:>-";
        cursorline = true;
        wrap = false;
        termguicolors = true;
      };
      keymaps = [
        {
          action = ":bd<CR>";
          key = "<leader>x";
        }
      ];
      plugins = {
        treesitter.enable = true;
        noice.enable = true;
        oil.enable = true;
        luasnip.enable = true;
        autoclose.enable = true;
        telescope = {
          enable = true;
          extensions = {
            fzf-native.enable = true;
          };
          settings = {
            defaults = {
              file_ignore_patterns = [
                "node_modules"
              ];
            };
          };
          keymaps = {
            "<leader>ff" = {
              action = "find_files, {}";
              options = {
                desc = "Find files";
              };
            };
            "<leader>fb" = {
              action = "buffers, {}";
              options = {
                desc = "Find buffers";
              };
            };
            "<leader>fd" = {
              action = "diagnostics, {}";
              options = {
                desc = "Find diagnostics";
              };
            };
          };
        };
        lualine = {
          enable = true;
        };
        lsp = {
          enable = true;
          servers = {
            astro.enable = true;
            nixd.enable = true;
            rust-analyzer = {
              enable = true;
              installRustc = false;
              installCargo = false;
            };
            gopls.enable = true;
          };
        };
        cmp.enable = true;
        cmp-buffer.enable = true;
        cmp-cmdline.enable = true;
        cmp-path.enable = true;
        cmp-nvim-lsp.enable = true;
        cmp-vsnip.enable = true;
        dap.enable = true;
      };
    };
  };

  home.stateVersion = "23.11";
}
