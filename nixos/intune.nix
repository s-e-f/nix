{ pkgs, inputs, ... }:
let
  microsoft-identity-broker = pkgs.microsoft-identity-broker.overrideAttrs {
    src = pkgs.fetchurl {
      url = "https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.0.1_amd64.deb";
      hash = "sha256-I4Q6ucT6ps8/QGiQTNbMXcKxq6UMcuwJ0Prcqvov56M=";
    };
  };
in
{
  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/security/intune.nix

  users.users.microsoft-identity-broker = {
    group = "microsoft-identity-broker";
    isSystemUser = true;
  };

  users.groups.microsoft-identity-broker = { };
  environment.systemPackages = [
    microsoft-identity-broker
    pkgs.intune-portal
  ];
  systemd.packages = [
    microsoft-identity-broker
    pkgs.intune-portal
  ];

  systemd.tmpfiles.packages = [ pkgs.intune-portal ];
  services.dbus.packages = [ microsoft-identity-broker ];
}
