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
    ./steam.nix
    ./theme.nix
  ];

  nixpkgs = {
    overlays = [
      inputs.nur.overlay
    ];
    config.allowUnfree = true;
    config.allowUnfreePredicate = (_: true);
  };

  security.pki.certificateFiles = [
    ../certs/leiden.crt
  ];

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        vivaldi-bin
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
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    systemPackages = with pkgs; [
      mako
      hyprcursor
      cliphist
      wl-clipboard
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
      rose-pine-cursor
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      pavucontrol
      noto-fonts
      gparted
    ];
  };

  security.polkit.enable = true;
  programs.gnupg.agent.enable = true;
  security.pam.services."1password".enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;

  services.gnome.gnome-keyring.enable = true;
  services.gnome.gnome-browser-connector.enable = true;

  boot = {
    loader = {
      systemd-boot.enable = true;
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

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        ovmf.enable = true;
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };

  services = {
    spice-vdagentd.enable = true;
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
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "libvirtd"
      "docker"
    ];
  };

  programs = {
    ssh.startAgent = true;
    hyprland.enable = true;
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

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    font-awesome
    roboto
  ];

  users.defaultUserShell = pkgs.zsh;

  system.stateVersion = "24.05";
}
