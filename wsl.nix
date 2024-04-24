# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  pkgs,
  config,
  ...
}: {
  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
  wsl = {
    enable = true;
    defaultUser = "sef";
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
    startMenuLaunchers = true;
    docker-desktop.enable = false;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };

  systemd.services.docker-desktop-proxy.script = pkgs.lib.mkForce ''${config.wsl.wslConf.automount.root}/wsl/docker-desktop/docker-desktop-user-distro proxy --docker-desktop-root ${config.wsl.wslConf.automount.root}/wsl/docker-desktop "C:\Program Files\Docker\Docker\resources"'';

  environment.systemPackages = with pkgs; [
    wget
  ];

  programs = {
    zsh = {
      enable = true;
    };
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.sef = {
    isNormalUser = true;
    description = "Sef";
    extraGroups = ["networkmanager" "wheel" "docker"];
  };
}
