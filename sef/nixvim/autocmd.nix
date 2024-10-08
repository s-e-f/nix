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
    ];
  };
}
