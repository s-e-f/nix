{
  pkgs,
  config,
  inputs,
  ...
}:
{
  programs.nixvim = {
    keymaps = [
      {
        action = "<cmd>nohlsearch<cr>";
        mode = "n";
        key = "<esc>";
      }
      {
        action = "<cmd>bd<cr>";
        mode = "n";
        key = "<leader>x";
      }
    ];
  };
}
