{ pkgs, config, ... }:
{
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        timeout_ms = 500;
        lsp_format = "fallback";
      };
      formatters_by_ft = {
        lua = [ "stylua" ];
        java = [ "google-java-format" ];
        nix = [ "nixfmt" ];
        cs = [ "csharpier" ];
      };
    };
  };
}
