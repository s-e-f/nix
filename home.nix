{
  config,
  pkgs,
  args,
  ...
}: {
  imports = [
    args.nixvim.homeManagerModules.nixvim
  ];

  home.username = "sef";
  home.homeDirectory = "/home/sef";

  home.packages = with pkgs; [
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

  services = {
    gpg-agent = {
      enableSshSupport = true;
    };
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
    ssh = {
      enable = true;
    };
    gpg = {
      enable = true;
    };
    git = {
      enable = true;
      userEmail = "39380372+s-e-f@users.noreply.github.com";
      userName = "Sef";
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
	  shellAliases = {
		l = "eza -l --icons --no-permissions --no-time --smart-group -a --git --total-size";
		npg = "nix-prefetch-github --nix";
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
        cmp = {
          enable = true;
        };
        dap = {
          enable = true;
        };
      };
    };
  };

  home.stateVersion = "23.11";
}
