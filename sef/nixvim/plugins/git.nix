{ pkgs, config, ... }:
{
  programs.nixvim.plugins = {
    gitsigns.enable = true;
  };
}
