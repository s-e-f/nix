{ pkgs, config, ... }:
{
  programs.nixvim.plugins.lualine = {
    enable = true;
    options = {
      icons_enabled = true;
    };
  };
}
