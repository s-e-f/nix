# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  config,
  lib,
  pkgs,
  ...
}: let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    ref = "nixos-23.11";
  });
in {
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
    nixvim.nixosModules.nixvim
  ];

  programs.nix-ld.enable = true;

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
      };
      plugins = {
        telescope = {
          enable = true;
        };
		lualine = {
		  enable = true;
		};
		lsp = {
		  enable = true;
		  servers = {
			nixd.enable = true;
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
