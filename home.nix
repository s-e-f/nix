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
      turso-cli
      sqld
      nix-prefetch-github
      dos2unix
      dotnetCorePackages.sdk_9_0
      flyctl
      gnumake
      zip
      tlrc
      delve
      erlang
      rebar3
      zig
      bun
      deno
      nodejs_22
      surrealdb
    ];
    sessionVariables = {
      EDITOR = "nvim";
    };
    file.".ssh/allowed_signers".text = ''
      ${email} ${public_key}
    '';
    file.".config/zellij/config.kdl".text = builtins.readFile ./config.kdl;
  };

  programs = {
    home-manager.enable = true;
    bat = {
      enable = true;
      themes = {
        cyberdream = {
          src = pkgs.fetchFromGitHub {
            owner = "scottmckendry";
            repo = "cyberdream.nvim";
            rev = "c3eff4c5df805bb9451129151509d5624295f416";
            hash = "sha256-VgTGXRoiCmvXjr/9d5YTouvYH7ItISAgSzdxMCO/3jA=";
          };
          file = "extras/textmate/cyberdream.tmTheme";
        };
      };
      config = {
        theme = "cyberdream";
      };
    };
    thefuck.enable = true;
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
      };
    };
    go = {
      enable = true;
      goBin = ".local/bin.go";
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
      initExtraFirst = ''
        export WINDOWS_USER=$(cmd.exe /c echo %USERNAME% 2>/dev/null | dos2unix)
      '';
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
    nixvim = {
      enable = true;
      colorschemes.cyberdream = {
        enable = true;
        settings = {
          transparent = true;
        };
      };
      extraConfigLua = ''
        vim.api.nvim_set_hl(0, 'CursorLine', { underline = true })
      '';
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
        expandtab = true;
        smartindent = true;
        autoindent = true;
        smarttab = true;
        cindent = true;
        cinkeys = "0{,0},0),0],:,!^F,o,O,e";
        list = true;
        listchars = "trail:+,tab:>-";
        cursorline = true;
        wrap = false;
        termguicolors = true;
        completeopt = "menu,menuone,noselect";
      };
      keymaps = [
        {
          action = ":bd<CR>";
          key = "<leader>x";
        }
        {
          action.__raw = ''
            function()
              local ls = require "luasnip"
              if ls.expand_or_jumpable() then
                  ls.expand_or_jump()
              end
            end
          '';
          key = "<C-k>";
          options = {
            silent = true;
          };
          mode = [ "i" "s" ];
        }
        {
          action.__raw = ''
            function()
                local ls = require "luasnip"
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end
          '';
          key = "<C-j>";
          options = {
            silent = true;
          };
          mode = [ "i" "s" ];
        }
      ];
      plugins = {
        treesitter.enable = true;
        oil.enable = true;
        luasnip.enable = true;
        surround.enable = true;
        autoclose.enable = true;
        trouble.enable = true;
        gitsigns.enable = true;
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
        notify = {
          enable = true;
          fps = 144;
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
              action = "find_files";
              options.desc = "Find files";
            };
            "<leader>fb" = {
              action = "buffers";
              options.desc = "Find buffers";
            };
            "<leader>fd" = {
              action = "diagnostics";
              options.desc = "Find diagnostics";
            };
            "<leader>fg" = {
              action = "live_grep";
              options.desc = "Live grep";
            };
          };
        };
        lualine.enable = true;
        lspkind = {
          enable = true;
          cmp.enable = true;
        };
        lsp = {
          enable = true;
          keymaps = {
            diagnostic = {
              "<leader>j" = "goto_next";
              "<leader>k" = "goto_prev";
              "<leader>le" = "open_float";
            };
            lspBuf = {
              K = "hover";
              gD = "references";
              gd = "definition";
              gi = "implementation";
              gt = "type_definition";
              "<leader>lc" = "code_action";
              "<leader>lr" = "rename";
            };
          };
          servers = {
            zls.enable = true;
            gleam =
              {
                enable = true;
                package = null; # gleam is installed manually from source
              };
            tsserver.enable = true;
            eslint = {
              enable = true;
              onAttach = {
                function = ''
                  vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    command = "EslintFixAll",
                  })
                '';
              };
            };
            astro.enable = true;
            nixd.enable = true;
            omnisharp.enable = true;
            rust-analyzer = {
              enable = true;
              installRustc = false;
              installCargo = false;
            };
            gopls.enable = true;
          };
        };
        lsp-format = {
          enable = true;
          setup = {
            javascript.exclude = [ "tsserver" ];
            javascriptreact.exclude = [ "tsserver" ];
            typescript.exclude = [ "tsserver" ];
            typescriptreact.exclude = [ "tsserver" ];
          };
        };
        cmp_luasnip.enable = true;
        none-ls = {
          enable = true;
          enableLspFormat = true;
          sources = {
            code_actions = { };

            completion = {
              luasnip.enable = true;
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
              markdownlint.enable = true;
              gofumpt.enable = true;
              nixpkgs_fmt.enable = true;
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
              { name = "nvim_lsp"; }
              { name = "path"; }
              { name = "buffer"; }
            ];
            mapping = {
              "<C-n>" = "cmp.mapping.select_next_item()";
              "<C-p>" = "cmp.mapping.select_prev_item()";
              "<C-e>" = "cmp.mapping.abort()";
              "<C-y>" = "cmp.mapping(cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true }, { \"i\", \"c\" })";
            };
            window = {
              completion = {
                __raw = "cmp.config.window.bordered()";
              };
              documentation = { __raw = "cmp.config.window.bordered()"; };
            };
          };
        };
        dap = {
          enable = true;
          extensions = {
            dap-go.enable = true;
            dap-ui.enable = true;
            dap-virtual-text.enable = true;
          };
        };
      };
    };
  };

  home.stateVersion = "23.11";
}
