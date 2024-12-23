{ pkgs, ... }:
{
  programs.nixvim.plugins.snacks = {
    enable = true;
    settings = {
      statuscolumn = {
        enable = true;
      };
      words = {
        enable = true;
      };
    };
  };
}
