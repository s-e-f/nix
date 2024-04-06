# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  self,
  pkgs,
  lib,
  config,
  ...
}:

{
  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  wsl = {
    enable = true;
    defaultUser = "sef";
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
    startMenuLaunchers = true;

    docker-desktop.enable = false;

    extraBin = with pkgs; [
      {src = "${coreutils}/bin/mkdir";}
      {src = "${coreutils}/bin/cat";}
      {src = "${coreutils}/bin/whoami";}
      {src = "${coreutils}/bin/ls";}
      {src = "${busybox}/bin/addgroup";}
      {src = "${su}/bin/groupadd";}
      {src = "${su}/bin/usermod";}
    ];
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };

  systemd.services.docker-desktop-proxy.script = lib.mkForce ''${config.wsl.wslConf.automount.root}/wsl/docker-desktop/docker-desktop-user-distro proxy --docker-desktop-root ${config.wsl.wslConf.automount.root}/wsl/docker-desktop "C:\Program Files\Docker\Docker\resources"'';

  programs.bash = {
    shellAliases = {
      docker = "/run/current-system/sw/bin/docker";
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    alejandra
    fzf
    ripgrep
    bat
    rustup
	surrealdb
	surrealdb-migrations
  ];

  programs = {
    starship = {
      enable = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      shellAliases = {
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https:sef//nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
