# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  pkgs,
  config,
  ...
}:

{
  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  wsl = {
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

  systemd.services.docker-desktop-proxy.script = pkgs.lib.mkForce ''${config.wsl.wslConf.automount.root}/wsl/docker-desktop/docker-desktop-user-distro proxy --docker-desktop-root ${config.wsl.wslConf.automount.root}/wsl/docker-desktop "C:\Program Files\Docker\Docker\resources"'';

  services = {
	  openssh = {
		  enable = true;
	  };
  };

  environment.systemPackages = with pkgs; [
    wget
    rustup
	surrealdb
	surrealdb-migrations
  ];

  programs = {
    zsh = {
      enable = true;
	  shellAliases = {
		docker ="/run/current-system/sw/bin/docker";
	  };
    };
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.sef = {
	  isNormalUser = true;
	  description = "Sef";
	  extraGroups = ["networkmanager" "wheel" "docker"];
  };
}
