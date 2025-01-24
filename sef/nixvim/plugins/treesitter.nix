{ pkgs, config, ... }:
{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings = {
      auto_install = true;
      ensure_installed = [
        "lua"
        "html"
        "markdown"
        "bash"
        "c"
        "vim"
        "vimdoc"
        "typescript"
        "tsx"
        "gleam"
      ];
      highlight.enable = true;
      indent.enable = true;
    };
  };
}
