{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      # TODO(ts_ls): server_capabilities.documentFormattingProvider = false
      ts_ls.enable = true;
      biome.enable = true;
      jsonls.enable = true;
      gleam.enable = true;
      zls.enable = true;
      nil_ls.enable = true;
      rust_analyzer = {
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
            __raw = "require('telescope.builtin').lsp_references";
          };
          key = "gr";
          mode = "n";
        }
        {
          action = {
            __raw = "require('telescope.builtin').lsp_definitions";
          };
          key = "gd";
          mode = "n";
        }
        {
          action = {
            __raw = "require('telescope.builtin').lsp_implementations";
          };
          key = "gi";
          mode = "n";
        }
        {
          action = {
            __raw = "require('telescope.builtin').lsp_type_definitions";
          };
          key = "gT";
          mode = "n";
        }
        {
          action = {
            __raw = "require('telescope.builtin').lsp_workspace_symbols";
          };
          key = "gs";
          mode = "n";
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
  programs.nixvim.plugins.nvim-jdtls = {
    enable = true;
    cmd = [
      (lib.getExe pkgs.jdt-language-server)
      "-data"
      "/home/sef/.cache/jdtls/workspace"
      "--jvm-arg=-javaagent:${pkgs.lombok}/share/java/lombok.jar"
    ];
  };
}
