{ pkgs, config, ... }:
{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      # TODO: server_capabilities.documentFormattingProvider = false
      ts-ls.enable = true;
      biome.enable = true;
      jsonls.enable = true;
      jdt-language-server.enable = true;
      gleam.enable = true;
      zls.enable = true;
      nil-ls.enable = true;
      rust-analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };
    };
    keymaps = {
      silent = true;
      extra = [
        {
          action = {
            __raw = "require('telescope.builtin').lsp_references()";
          };
          key = "gr";
        }
        {
          action = {
            __raw = "require('telescope.builtin').lsp_definitions()";
          };
          key = "gd";
        }
        {
          action = {
            __raw = "require('telescope.builtin').lsp_implementations()";
          };
          key = "gi";
        }
        {
          action = {
            __raw = "require('telescope.builtin').lsp_type_definitions()";
          };
          key = "gT";
        }
        {
          action = {
            __raw = "require('telescope.builtin').lsp_workspace_symbols()";
          };
          key = "gs";
        }
      ];
      diagnostic = {
        "<leader>le" = "open_float";
      };
      lspBuf = {
        "gD" = "declaration";
        "K" = "hover";
        "<leader>lr" = "rename";
        "<leader>lc" = "code_action";
      };
    };
  };
}
