{ pkgs, ... }:
{
  programs.nixvim.plugins = {
    ts-autotag.enable = true;
    autoclose.enable = true;
  };
}
