{ pkgs, inputs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    NIL_PATH = "${pkgs.nil}/bin/nil";
  };
  home.packages = with pkgs; [
    gnumake
    gcc
    tree-sitter
    lua-language-server
    zig
  ];
  home.file.".config/nvim" = {
    source = ./.;
    recursive = true;
  };
}
