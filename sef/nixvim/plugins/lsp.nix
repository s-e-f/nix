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
      gopls.enable = true;
      ts_ls = {
        enable = true;
        rootDir = ''
          require 'lspconfig.util'.root_pattern('package.json')
        '';
        settings = {
          completions.completeFunctionCalls = true;
        };
      };
      denols = {
        enable = true;
        rootDir = ''
          require 'lspconfig.util'.root_pattern('deno.json', 'deno.jsonc')
        '';
      };
      #biome.enable = true;
      csharp_ls = {
        enable = false;
        package = null;
        cmd = [ "csharp-ls" ];
        settings = {
          csharp.solution = {
            __raw = ''
              (function()
                local cwd = vim.fn.getcwd()
                local sln_files = vim.fn.glob(cwd .. '/*.sln', false, true)
                if #sln_files > 0 then
                  return vim.fn.fnamemodify(sln_files[1], ':p')
                else
                  return ""
                end
              end)()
            '';
          };
        };
      };
      cssls.enable = true;
      css_variables = {
        enable = true;
        package = null; # Installed globally with Bun
      };
      cssmodules_ls = {
        enable = true;
        package = null; # Installed globally with Bun
      };
      jsonls.enable = true;
      gleam.enable = true;
      zls = {
        enable = true;
        package = null;
        cmd = [ "zls" ];
        settings = {
          enable_build_on_save = true;
          build_on_save_step = "check";
        };
      };
      pylsp.enable = false;
      nixd = {
        enable = true;
        settings = {
          nixpkgs.expr = "import <nixpkgs> { }";
          options = {
            crypt.expr = "(builtins.getFlake \"/home/sef/.config/nix/flake.nix\").nixosConfigurations.crypt.options";
            hm_sef.expr = "(builtins.getFlake \"/home/sef/.config/nix/flake.nix\").homeConfigurations.sef.options";
            hm_vintus_sef.expr = "(builtins.getFlake \"/home/sef/.config/nix/flake.nix\").homeConfigurations.vintus-sef.options";
          };
        };
      };
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
