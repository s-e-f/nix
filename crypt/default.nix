{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ../hardware/crypt.nix
    ./docker.nix
    ./nvidia.nix
    ./gaming.nix
    ./thunar.nix
    ../modules/stylix.nix
  ];

  nixpkgs = {
    overlays = [
      inputs.nur.overlays.default
    ];
    config.allowUnfree = true;
    config.allowUnfreePredicate = (_: true);
  };

  security.pki.certificateFiles = [
    ../certs/leiden.crt
  ];

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://hyprland.cachix.org"
        "https://ghostty.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
      ];
    };
  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        vivaldi-bin
        .zen-wrapped
        zen
      '';
      mode = "0755";
    };
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    openssl
    curl
  ];

  environment = {
    systemPackages = with pkgs; [
      hyprcursor
      wl-clipboard
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
      rose-pine-cursor
      pavucontrol
      gparted
      libnotify
    ];
  };

  fonts.packages = with pkgs; [
    font-awesome # for waybar
    noto-fonts
    noto-fonts-emoji
  ];

  security.polkit.enable = true;
  programs.gnupg.agent.enable = true;
  security.pam.services."1password".enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;

  services.gnome.gnome-keyring.enable = true;
  services.gnome.gnome-browser-connector.enable = true;

  boot = {
    loader = {
      systemd-boot.enable = false;
      grub = {
        enable = true;
        efiSupport = true;
        devices = [ "nodev" ];
        enableCryptodisk = true;
        efiInstallAsRemovable = false;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "crypt";
    # wireless.enable = true;
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Amsterdam";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "nl_NL.UTF-8";
      LC_IDENTIFICATION = "nl_NL.UTF-8";
      LC_MEASUREMENT = "nl_NL.UTF-8";
      LC_MONETARY = "nl_NL.UTF-8";
      LC_NAME = "nl_NL.UTF-8";
      LC_NUMERIC = "nl_NL.UTF-8";
      LC_PAPER = "nl_NL.UTF-8";
      LC_TELEPHONE = "nl_NL.UTF-8";
      LC_TIME = "nl_NL.UTF-8";
    };
  };

  services = {
    printing.enable = true;
    hypridle.enable = true;
    openssh.enable = true;
  };

  security.rtkit.enable = true;

  services = {
    fprintd = {
      enable = true;
      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-goodix-550a;
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      jack.enable = true;
    };
  };

  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;

  users.users.sef = {
    isNormalUser = true;
    description = "Sef";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "docker"
    ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  programs = {
    ssh.startAgent = true;
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    hyprlock.enable = true;
    waybar.enable = true;
    zsh.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "sef" ];
    };
    _1password.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/sef/.config/nix";
    };
  };

  users.defaultUserShell = pkgs.zsh;

  system.stateVersion = "24.05";
}
