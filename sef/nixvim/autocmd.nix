{
  pkgs,
  config,
  inputs,
  ...
}:
{
  programs.nixvim = {
    autoGroups = {
      "kickstart-highlight-yank" = {
        clear = true;
      };
      "sef-lsp-typescript" = {
        clear = true;
      };
    };
    autoCmd = [
      {
        callback = {
          __raw = "function() vim.highlight.on_yank() end";
        };
        desc = "Highlight when yanking text";
        group = "kickstart-highlight-yank";
        event = [ "TextYankPost" ];
      }
      {
        callback = {
          __raw = ''
            function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              local is_node_project = vim.fn.filereadable("package.json") == 1
              local is_deno_project = vim.fn.filereadable("deno.json") == 1

              if client.name == "denols" and is_node_project then
                client.stop()
              end

              if client.name == "ts_ls" and is_deno_project then
                client.stop()
              end
            end
          '';
        };
        desc = "Choose between ts_ls and denols";
        group = "sef-lsp-typescript";
        event = [ "LspAttach" ];
      }
    ];
  };
}
