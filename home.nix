{ config
, pkgs
, args
, ...
}:
let
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEWzfajaOsrjRi9VBZ1eZHndHr/8HoIZT6szzySUVHAF";
  email = "39380372+s-e-f@users.noreply.github.com";
in
{
  imports = [
    args.nixvim.homeManagerModules.nixvim
  ];

  home = {
    username = "sef";
    homeDirectory = "/home/sef";
    packages = with pkgs; [
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
      dos2unix
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
      initExtraFirst = ''
        		  export WINDOWS_USER=$(cmd.exe /c echo %USERNAME% 2>/dev/null)
        		  '';
      shellAliases = {
        l = "eza -l --icons --no-permissions --no-time --smart-group -a --git";
        ls = "eza";
        npg = "nix-prefetch-github --nix";
        cat = "bat";
        nix-format = "alejandra *.nix";
        op = "/mnt/c/Users/$WINDOWS_USER/AppData/Local/Microsoft/WinGet/Links/op.exe";
        v = "nvim";
      };
    };
    zellij = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        theme = "catppuccin-mocha";
        pane_frames = false;
        copy_on_select = false;
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
        oil.enable = true;
        luasnip.enable = true;
        autoclose.enable = true;
        trouble.enable = true;
        noice = {
          enable = true;
          lsp = {
            override = {
              "vim.lsp.util.convert_input_to_markdown_lines" = true;
              "vim.lsp.util.stylize_markdown" = true;
              "cmp.entry.get_documentation" = true;
            };
            hover.enabled = true;
          };
        };
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
        lualine.enable = true;
        lsp = {
          enable = true;
          keymaps = {
            diagnostic = {
              "<leader>j" = "goto_next";
              "<leader>k" = "goto_prev";
            };
            lspBuf = {
              K = "hover";
              gD = "references";
              gd = "definition";
              gi = "implementation";
              gt = "type_definition";
              "<leader>lc" = "code_action";
            };
          };
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
        lsp-format.enable = true;
        none-ls = {
          enable = true;
          enableLspFormat = true;
          sources = {
            code_actions = { };

            completion = {
              luasnip.enable = true;
              spell.enable = true;
              vsnip.enable = true;
            };

            diagnostics = {
              actionlint.enable = true;
              ansiblelint.enable = true;
              checkmake.enable = true;
              deadnix.enable = true;
              dotenv_linter.enable = true;
              golangci_lint.enable = true;
              hadolint.enable = true;
              proselint.enable = true;
              selene.enable = true;
              sqlfluff.enable = true;
              statix.enable = true;
              stylelint.enable = true;
              tidy.enable = true;
              yamllint.enable = true;
            };

            formatting = {
              cbfmt.enable = true;
              markdownlint.enable = true;
              gofumpt.enable = true;
              nixpkgs_fmt.enable = true;
              prettier = {
                enable = true;
                disableTsServerFormatter = true;
              };
              sqlfluff.enable = true;
              stylua.enable = true;
              tidy.enable = true;
            };
          };
        };
        cmp = {
          enable = true;
          settings = {
            snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
            sources = [
              { name = "path"; }
              { name = "nvim_lsp"; }
              { name = "cmp_tabby"; }
              { name = "luasnip"; }
              { name = "neorg"; }
            ];
          };
        };
        dap.enable = true;
      };
    };
  };

  home.stateVersion = "23.11";
}
