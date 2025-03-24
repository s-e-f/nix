{ pkgs, inputs, ... }:
{
  # virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;
  programs.zsh.shellAliases = {
    docker = "podman";
  };
}
