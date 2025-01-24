{
  pkgs,
  lib,
  ...
}:
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
        hcl = [ "hcl" ];
        gleam = [ "gleam" ];
      };
      formatters = {
        hcl = {
          command = (lib.getExe pkgs.hclfmt);
        };
        csharpier = {
          command = (
            lib.getExe (
              pkgs.writeShellApplication {
                name = "csharpier";
                text = ''
                  dotnet csharpier "$@"
                '';
              }
            )
          );
        };
      };
    };
  };
}
