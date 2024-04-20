{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
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
  ];

  programs = {
	home-manager.enable = true;

	git.enable = true;
	zsh = {
		enable = true;
		enableCompletion = true;
		enableVteIntegration = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;
	};
	zellij ={
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
        flavour = "mocha";
        transparentBackground = true;
      };
      globals = {
        mapleader = " ";
      };
      options = {
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
      plugins = {
        treesitter.enable = true;
        telescope = {
          enable = true;
          extensions = {
            fzf-native.enable = true;
          };
          defaults = {
            file_ignore_patterns = [
              "node_modules"
            ];
          };
          keymaps = {
            "<leader>ff" = {
              action = "find_files, {}";
              desc = "Find files";
            };
            "<leader>fb" = {
              action = "buffers, {}";
              desc = "Find buffers";
            };
            "<leader>fd" = {
              action = "diagnostics, {}";
              desc = "Find diagnostics";
            };
          };
        };
        lualine = {
          enable = true;
        };
        lsp = {
          enable = true;
          servers = {
            nixd.enable = true;
            rust-analyzer = {
              enable = true;
              installRustc = false;
              installCargo = false;
            };
          };
        };
      };
    };
  };

  home.stateVersion = "23.11";
}
