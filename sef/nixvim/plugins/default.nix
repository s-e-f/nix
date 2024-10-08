{ pkgs, config, ... }:
{
  imports = [
    ./autopairs.nix
    ./oil.nix
    ./telescope.nix
    ./treesitter.nix
    ./lualine.nix
    ./surround.nix
    ./git.nix
    ./lsp.nix
    ./cmp.nix
    ./conform.nix
  ];
}
