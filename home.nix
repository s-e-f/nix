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
    bat
    btop
    rustup
    surrealdb
    nodejs_21
  ];

  services = {
    gpg-agent = {
      enableSshSupport = true;
    };
  };

  programs = {
    home-manager.enable = true;
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
