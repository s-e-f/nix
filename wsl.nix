# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{ pkgs
, config
, ...
}: {
  programs.nix-ld = {
    enable = true;
    libraries = [ ];
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  wsl = {
    enable = true;
    defaultUser = "sef";
    wslConf = {
      automount.root = "/mnt";
      interop.appendWindowsPath = true;
      network.generateHosts = false;
    };
    startMenuLaunchers = true;
    #docker-desktop.enable = true;
  };

  virtualisation.docker.enable = true;

  #systemd.services.docker-desktop-proxy = {
  #script = pkgs.lib.mkForce ''
  #sudo ${config.wsl.wslConf.automount.root}/wsl/docker-desktop/docker-desktop-user-distro proxy --distro-name NixOS "C:\Program Files\Docker\Docker\resources"
  #'';
  #};

  environment.systemPackages = with pkgs; [
    wget
  ];

  programs = {
    zsh = {
      enable = true;
    };
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/sef/.nix/";
    };
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.sef = {
    isNormalUser = true;
    description = "Sef";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
}
