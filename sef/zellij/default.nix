{ pkgs, inputs, ... }:
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };
  home.file.".config/zellij/config.kdl".text = builtins.readFile ./config.kdl;
}
