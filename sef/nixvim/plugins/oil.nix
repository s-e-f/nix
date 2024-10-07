{ pkgs, config, ... }:
{
  programs.nixvim.plugins.oil = {
    enable = true;
  };
  programs.nixvim.keymaps = [
    {
      action = "<cmd>Oil<cr>";
      mode = "n";
      key = "-";
      options = { };
    }
  ];
}
