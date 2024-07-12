{ config
, pkgs
, args
, obsidian_vaults
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
      flyctl
      zip
      tlrc
      erlang
      rebar3
      surrealdb
      usql
    ];
    sessionVariables = {
      EDITOR = "nvim";
      MSBUILDTERMINALLOGGER = "auto";
    };
    file.".config/zellij/config.kdl".text = builtins.readFile ./zellij/config.kdl;
  };

  programs = {
    home-manager.enable = true;
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
    nixvim = {
      enable = true;
      colorschemes.cyberdream = {
        enable = true;
        settings = {
          transparent = true;
        };
      };
      globals = {
        mapleader = " ";
      };
      autoCmd = [
        {
          event = [ "BufEnter" ];
          pattern = [ "*.lua" "*.nix" "*.astro" "*.gleam" "*.csproj" "*.xml" "*.json" "*.yaml" "*.yml" ];
          callback = {
            __raw = ''
              function()
                vim.opt.shiftwidth = 2
                vim.opt.tabstop = 2
                vim.opt.softtabstop = 2
              end
            '';
          };
        }
        {
          event = [ "BufWritePre" ];
          pattern = [ "*.ts" "*.js" "*.tsx" "*.jsx" ];
          callback = {
            __raw = ''
              function()
                if vim.fn.exists(':EslintFixAll') > 0 then
                  vim.cmd('EslintFixAll')
                else
                  vim.lsp.buf.format()
                end
              end
            '';
          };
        }
      ];
      opts = {
        number = true;
        relativenumber = true;
        clipboard = "unnamedplus";
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
        conceallevel = 2;
      };
      keymaps = [
        {
          action = ":Oil<CR>";
          key = "-";
        }
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
        ts-autotag.enable = true;
        gitsigns.enable = true;
        obsidian = {
          enable = true;
          settings = {
            workspaces = [
              {
                name = "Workspace";
                path = "${obsidian_vaults}";
              }
            ];
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
              action = "find_files";
              options.desc = "Find files";
            };
            "gD" = {
              action = "lsp_references";
              options.desc = "Find references";
            };
            "<leader>fa" = {
              action = "git_files";
              options.desc = "Find tracked files";
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
              # gD is bound through Telescope
              # gD = "references";
              gd = "definition";
              gi = "implementation";
              gt = "type_definition";
              "<leader>lc" = "code_action";
              "<leader>lr" = "rename";
            };
          };
          servers = {
            zls.enable = true;
            gleam.enable = true;
            tsserver = {
              enable = true;
              settings = {
                completions = {
                  completeFunctionCalls = true;
                };
              };
            };
            eslint.enable = true;
            astro.enable = true;
            nixd.enable = true;
            omnisharp.enable = true;
            rust-analyzer = {
              enable = true;
              installRustc = false;
              installCargo = false;
            };
            gopls.enable = true;
            biome.enable = true;
          };
        };
        cmp-nvim-lsp.enable = true;
        cmp-nvim-lsp-document-symbol.enable = true;
        cmp-nvim-lsp-signature-help.enable = true;
        cmp_luasnip.enable = true;
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
