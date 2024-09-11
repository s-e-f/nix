{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ../hardware/vintus-laptop.nix
    ./docker.nix
    ./intune.nix
    ./gnome.nix
  ];

  nixpkgs = {
    overlays = [
      inputs.nur.overlay
      (final: prev: {
        microsoft-identity-broker = prev.microsoft-identity-broker.overrideAttrs {
          src = pkgs.fetchurl {
            url = "https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.0.1_amd64.deb";
            hash = "sha256-I4Q6ucT6ps8/QGiQTNbMXcKxq6UMcuwJ0Prcqvov56M=";
          };
        };
      })
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

  console = {
    font = "ter-u16n";
    packages = with pkgs; [ terminus_font ];
    earlySetup = true;
    colors = [
      "0d0c0c"
      "c4746e"
      "8a9a7b"
      "c4b28a"
      "8ba4b0"
      "a292a3"
      "8ea4a2"
      "c8c093"
      "a6a69c"
      "e46876"
      "87a987"
      "e6c384"
      "7fb4ca"
      "938aa9"
      "7aa89f"
      "c5c9c5"
    ];
  };

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
      microsoft-edge
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
    initrd.luks.devices."luks-5b3969d7-403a-429d-86d3-0c05a948b453".device = "/dev/disk/by-uuid/5b3969d7-403a-429d-86d3-0c05a948b453";
  };

  networking = {
    hostName = "nixos";
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
