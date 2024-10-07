{ pkgs, config, ... }:
{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings = {
      auto_install = true;
      ensure_installed = "all";
      highlight.enable = true;
      indent.enable = true;
    };
  };
}
