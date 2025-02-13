{
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    hclfmt
    python313Packages.mdformat
    python313Packages.mdformat-frontmatter
  ];

  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        timeout_ms = 1000;
        lsp_format = "fallback";
      };
      formatters_by_ft = {
        lua = [ "stylua" ];
        java = [ "google-java-format" ];
        nix = [ "nixfmt" ];
        cs = [ "csharpier" ];
        hcl = [ "hcl" ];
        gleam = [ "gleam" ];
        markdown = [ "mdformat" ];
      };
      formatters = {
        mdformat = {
          command = "mdformat";
          "inherit" = false;
          args = [ "-" ];
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
