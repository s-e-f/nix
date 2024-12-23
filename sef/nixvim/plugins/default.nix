{ ... }:
{
  imports = [
    ./autopairs.nix
    ./cmp.nix
    ./colorizer.nix
    ./conform.nix
    ./git.nix
    ./lsp.nix
    ./lualine.nix
    ./oil.nix
    ./snacks.nix
    ./surround.nix
    ./telescope.nix
    ./treesitter.nix
  ];
  programs.nixvim.plugins = {
    web-devicons.enable = true;
    mini.enable = true;
  };
}
