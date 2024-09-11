{ pkgs, inputs, ... }:
{
  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/security/intune.nix

  services.intune.enable = true;
  # users.users.microsoft-identity-broker = {
  #   group = "microsoft-identity-broker";
  #   isSystemUser = true;
  # };
  #
  # users.groups.microsoft-identity-broker = { };
  # environment.systemPackages = [
  #   microsoft-identity-broker
  #   pkgs.intune-portal
  #   pkgs.msalsdk-dbusclient
  # ];
  # systemd.packages = [
  #   microsoft-identity-broker
  #   pkgs.intune-portal
  # ];
  #
  # systemd.tmpfiles.packages = [
  #   pkgs.intune-portal
  # ];
  # services.dbus.packages = [
  #   microsoft-identity-broker
  # ];
}
