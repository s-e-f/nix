{ pkgs, config, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    opts = {
      completeopt = [
        "menu"
        "menuone"
        "noselect"
      ];
    };
  };

  imports = [
    ./filetypes.nix
    ./plugins
  ];
}
