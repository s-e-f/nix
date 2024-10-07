{ pkgs, config, ... }:
{
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
      media-files.enable = true;
    };
    keymaps = {
      "<leader>ff" = {
        action = "find_files";
        options.silent = true;
      };
      "<leader>fh" = {
        action = "help_tag";
        options.silent = true;
      };
      "<leader>fg" = {
        action = "live_grep";
        options.silent = true;
      };
    };
  };
}
