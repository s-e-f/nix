{ pkgs, ... }:
{
  programs.nixvim.plugins = {
    nvim-autopairs.enable = true;
    autoclose.enable = true;
  };
}
